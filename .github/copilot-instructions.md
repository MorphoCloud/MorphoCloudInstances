# GitHub Copilot Instructions for MorphoCloudWorkflow

## Vendorizing to a target repository

**ALWAYS use the nox vendorize session. NEVER use rsync, `cp`, or any other
manual file copying.**

```bash
cd ~/Desktop/Projects/MorphoCloudWorkflow
# Ensure the correct branch is checked out first (e.g. intake-redesign-individual)
pipx run nox -s vendorize -- ~/Desktop/Projects/<TargetRepo>/ --commit
cd ~/Desktop/Projects/<TargetRepo>
git push origin main
```

The nox session handles correct file selection, exclusions (e.g.
`dependabot.yml`), and generates the proper commit message with a full
`git shortlog`. See [MAINTENANCE.md](../MAINTENANCE.md) for the full protocol
reference.

### Target repositories

| Repo                         | Purpose                       | Policy                                                                  |
| ---------------------------- | ----------------------------- | ----------------------------------------------------------------------- |
| `MorphoCloudInstancesTest`   | Test environment              | OK to vendorize freely                                                  |
| `MorphoCloudInstances`       | **Production**                | **DO NOT touch without explicit user instruction**                      |
| `MorphoCloudCourseTemplate ` | Template for new course repos | OK to vendorize, but do not make any manual changes to this repo either |

## Branch policy

| Branch                       | Purpose                                                      |
| ---------------------------- | ------------------------------------------------------------ |
| `main`                       | Stable production-ready code — dep bumps and hotfixes only   |
| `intake-redesign-individual` | Active feature development — vendorize from here for testing |

Never merge `intake-redesign-individual` into `main` without explicit user
instruction.

## git commit hygiene

- Never use `git add -A` or `git add .` — always stage files explicitly by name.

---

## Workflow entry points — which file handles what

| User action                                   | Triggering workflow file                                             |
| --------------------------------------------- | -------------------------------------------------------------------- |
| `/create` on an **individual** instance issue | `create-instance.yml` (label: `request-type:instance`)               |
| `/create` on a **course** instance issue      | `create-course-instance.yml` (label: `request-type:course-instance`) |
| `/create` on a **workshop** issue             | `create-workshop.yml`                                                |
| Any `/action` on an existing instance         | `control-instance.yml` → calls `control-instance-from-workflow.yml`  |
| Scheduled shelving                            | `automatic-instance-shelving.yml`                                    |
| Scheduled deletion                            | `automatic-instance-deleting.yml`                                    |

`create-instance-from-workflow.yml` is a **reusable workflow called internally**
— it is NOT triggered directly by issue comments. Do not assume it is the entry
point for `/create`.

---

## Composite action constraints

**Composite actions (`action.yml`) cannot access `vars`, `secrets`, or `env`
contexts.** Only `inputs`, `outputs`, and `steps` contexts work inside a
composite action.

Any repo variable or secret that a composite action needs **must be passed as an
`input`** from the calling workflow. Putting `${{ vars.SOMETHING }}` inside an
`action.yml` `env:` block will fail at runtime with "Unrecognized named-value" —
and pre-commit hooks will NOT catch this.

---

## Before making any changes

1. Read the triggering workflow file first to understand the call chain
2. Confirm whether you are editing the source (`MorphoCloudWorkflow`) or a
   vendorized copy (`MC-*`, `MorphoCloudInstancesTest`)
3. And changes to main branch is forbidden without explicit user instruction.
4. Do not make any changes to files or GitHub resources without explicit user
   instruction
