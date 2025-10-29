#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<EOF
Usage: $0 [-p prefix] [-w workshop-id]

  -p prefix       Filter instances by name prefix (default: 'instance')
  -w workshop-id  Filter instances associated with the specified workshop issue number
  -h              Show this help message
EOF
  exit 1
}

INSTANCE_NAME_PREFIX="instance"
WORKSHOP_ID=""
while getopts ":p:w:h" opt; do
  case ${opt} in
    p) INSTANCE_NAME_PREFIX="${OPTARG}" ;;
    w) WORKSHOP_ID="${OPTARG}" ;;
    h) usage ;;
    \?) echo "Error: Invalid option -${OPTARG}" >&2; usage ;;
    :) echo "Error: Option -${OPTARG} requires an argument." >&2; usage ;;
  esac
done
shift $((OPTIND -1))

# Attempt to auto-activate the Python environment
if ! command -v "openstack" &>/dev/null; then
  ACTIVATE_PATH="$HOME/venv/bin/activate"
  if [[ -r "$ACTIVATE_PATH" ]]; then

    . $ACTIVATE_PATH

    # Re-check after activating
    if ! command -v openstack >/dev/null 2>&1; then
      echo "Warning: Sourced '$ACTIVATE_PATH' but 'openstack' is still not in PATH" >&2
    fi
  else
    echo "Warning: OpenStack CLI not found and venv activate script missing at '$ACTIVATE_PATH'" >&2
  fi
fi

# Prerequisites
for cmd in openstack jq ssh curl; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "Error: required command '$cmd' not found in PATH." >&2
    exit 1
  fi
done

# Workshop filtering
declare -A WORKSHOP_INSTANCES=()

if [[ -n "$WORKSHOP_ID" ]]; then
  if ! command -v gh &>/dev/null; then
    echo "Error: required command 'gh' not found in PATH when using -w." >&2
    exit 1
  fi

  if [[ -z "${GH_TOKEN:-}" ]]; then
    echo "Error: GH_TOKEN must be set when using -w." >&2
    exit 1
  fi

  if [[ -z "${GH_REPO:-}" ]]; then
    GH_REPO=$(gh repo view --json nameWithOwner --jq .nameWithOwner 2>/dev/null) || true
  fi

  : "${GH_REPO:?Environment variable GH_REPO must be set or gh repo view must succeed}"

  mapfile -t WORKSHOP_ISSUE_NUMBERS < <(
    gh api \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      "repos/$GH_REPO/issues/$WORKSHOP_ID/sub_issues" \
      --paginate \
      --jq '.[].number'
  )

  if [[ ${#WORKSHOP_ISSUE_NUMBERS[@]} -eq 0 ]]; then
    echo "Warning: no instance issues found for workshop #${WORKSHOP_ID}" >&2
  fi

  for issue_number in "${WORKSHOP_ISSUE_NUMBERS[@]}"; do
    if [[ -n "$INSTANCE_NAME_PREFIX" ]]; then
      instance_name="${INSTANCE_NAME_PREFIX}_instance-${issue_number}"
    else
      instance_name="instance-${issue_number}"
    fi
    WORKSHOP_INSTANCES["$instance_name"]=1
  done
fi

# Attempt to auto‑set OS_CLOUD if not already provided
if [[ -z "${OS_CLOUD:-}" ]]; then
  config="$HOME/.config/openstack/clouds.yaml"
  if [[ -r "$config" ]]; then
    # extract the first top‑level key under "clouds:"
    OS_CLOUD=$(grep -oP '(?<=^  )[A-Za-z0-9_]+(?=:)' "$config" | head -n1)
    export OS_CLOUD
  fi
fi

: "${OS_CLOUD:?Environment variable OS_CLOUD must be set}"

# Header
echo "instance name,ssh,web connect,passphrase"

openstack server list --name "^$INSTANCE_NAME_PREFIX" --status ACTIVE -f json -c "Name" -c "Status" -c "Networks" | \
  jq -c '.[]' | while read -r instance_json; do

    INSTANCE_NAME=$(echo "$instance_json" | jq -r '.Name')
    INSTANCE_IP=$(echo "$instance_json" | jq -r '.Networks.auto_allocated_network[1]')

    if [[ -n "$WORKSHOP_ID" && -z "${WORKSHOP_INSTANCES[$INSTANCE_NAME]:-}" ]]; then
      continue
    fi

    # See hard-coded value in exosphere/src/Helpers/Interaction.elm
    guacamole_port=49528

    # See cloud_configs.js (allocation region is "IU")
    proxy_hostname=proxy-js2-iu.exosphere.app

    # See "buildProxyUrl" in src/Helpers/Url.elm
    proxified_instance_ip=${INSTANCE_IP//./-}

    # See hard-coded value in exosphere/src/Helpers/Interaction.elm
    client_id=ZGVza3RvcABjAGRlZmF1bHQ

    connection_url="https://http-$proxified_instance_ip-$guacamole_port.$proxy_hostname/guacamole/#/client/$client_id="

    # Get instance password from tags
    instance_pwd=$(
      openstack server show "$INSTANCE_NAME" -c tags -f json | \
      jq -r '.tags[] | select(startswith("exoPw")) | sub("^exoPw:"; "")'
    )

    # Since 'exoPw' tag may not yet set, attempt to directly retrieve the password using
    # the openstack endpoint local to the instance.
    if [[ -z "$instance_pwd" ]]; then
      function retrieve_password {
        instance_pwd=$(ssh \
          -o StrictHostKeyChecking=no \
          -o UserKnownHostsFile=/dev/null \
          -o LogLevel=ERROR \
          exouser@$proxified_instance_ip \
          'curl --silent http://169.254.169.254/openstack/latest/password')
        echo "$instance_pwd"
      }
      echo "Password not found in tags, attempting to retrieve via SSH..." >&2
      for attempt in {1..2}; do
        instance_pwd=$(retrieve_password)
        if [[ -n "$instance_pwd" ]]; then
          break
        fi
        echo "Retrying password retrieval ($attempt)..." >&2
        sleep 20
      done
    fi

    if [[ -z "$instance_pwd" ]]; then
      echo "Error: Failed to retrieve password for $INSTANCE_NAME" >&2
    fi

    echo "$INSTANCE_NAME,exouser@$INSTANCE_IP,$connection_url,$instance_pwd"
done
