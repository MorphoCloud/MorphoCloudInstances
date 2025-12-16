### Supported Issue Commands

_The commands described below may be added as issue comments. Only one command
may be entered per comment._

| Command            | Description                                                   | Who                  |
| ------------------ | ------------------------------------------------------------- | -------------------- |
| `/approve`         | Grant requestor the right to manage instance and volume.      | Admin                |
| `/create`          | Create the instance and associated volume.                    | Issue creator, Admin |
| `/shelve`          | Shelve the instance.                                          | Issue creator, Admin |
| `/unshelve`        | Unshelve the instance.                                        | Issue creator, Admin |
| `/email`           | Send email to _Issue creator_ with connection URL.            | Issue creator, Admin |
| `/renew`           | Extend the instance for another 60 days (one time only)       | Issue creator, Admin |
| `/encode_email`    | Update issue description obfuscating emails.                  | Issue creator, Admin |
| `/decode_email`    | Update issue description deobfuscating emails.                | Issue creator, Admin |
| `/delete_instance` | Delete only the instance.                                     | Issue creator, Admin |
| `/delete_volume`   | Delete only the volume.                                       | Issue creator, Admin |
| `/delete_all`      | Delete both the instance and volume.                          | Issue creator, Admin |
| `/unapprove`       | Remove requestor's right to manage instance and volume.       | Admin                |

_Once approved, the issue creator can run `/create`, `/delete_instance`,
`/delete_volume`, and `/delete_all`._
