### Supported Issue Commands

_The commands described below may be added as issue comments. Only one command
may be entered per comment._

| Command            | Description                                                   | Who                  |
| ------------------ | ------------------------------------------------------------- | -------------------- |
| `/shelve`          | Shelve the instance.                                          | Issue creator, Admin |
| `/unshelve`        | Unshelve the instance.                                        | Issue creator, Admin |
| `/encode_email`    | Update issue description obfuscating emails.                  | Issue creator, Admin |
| `/decode_email`    | Update issue description deobfuscating emails.                | Issue creator, Admin |
| `/email`           | Send email to _Issue creator_ with connection URL.            | Issue creator, Admin |
| `/renew`           | Extend the instance lifespan if additional time is available. | Issue creator, Admin |
| `/create`          | Create the instance and associated volume.                    | Issue creator, Admin |
| `/delete_instance` | Delete the instance.                                          | Issue creator, Admin |
| `/delete_volume`   | Delete the volume.                                            | Issue creator, Admin |
| `/delete_all`      | Delete the instance and volume.                               | Issue creator, Admin |
| `/approve`         | Grant issue creator right to manage instance and volume.      | Admin                |
| `/unapprove`       | Remove issue creator right to manage instance and volume.     | Admin                |

_Once approved, the issue creator can run `/create`, `/delete_instance`,
`/delete_volume`, and `/delete_all`._
