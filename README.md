<p align="center" >  <img src="https://raw.githubusercontent.com/MorphoCloud/MorphoCloudInstances/main/MC_Logo.png" alt="SlicerMorph on the cloud" width="300"></p>

# MorphoCloud On-Demand Instances: Run 3D Slicer and SlicerMorph inside a web browser.

Powerful virtual machines (compute instances) that provide interactive remote
desktop interface with [3D Slicer](https://download.slicer.org) and
[SlicerMorph](https://SlicerMorph.org) and its related extensions preloaded for
3D digital morphology and morphometrics data processing.

In a nutshell, you:

1. Have a research and/or teaching focus centered on 3D biological structure
   (e.g., 3D morphometrics, or visualization);
2. Need occasional access to powerful computers with large amounts of RAM and
   GPU (up to 40GB GPU)
3. You have a github account;
4. You have an ORCID with a public profile.

Also, note that any use case falls under the category of **Human Subject
Research** is not allowed on MorphoCloud.

To get more information about these instances, please review
[this document](https://docs.google.com/document/d/1WRds-QWnDK1MnmEhGUPyBgjE9hitiddcElAPWiAYRg4/edit#heading=h.b0yi3m7wlfk8).

## Available Instance Types

| Flavor   | RAM    | Cores | GPU         | **Storage** |
| -------- | ------ | ----- | ----------- | ----------- |
| g3.l\*\* | 60GB   | 16    | A100 (20GB) | 100GB       |
| g3.xl    | 125GB  | 32    | A100 (40GB) | 100GB       |
| m3.x     | 250GB  | 64    | None        | 100GB       |
| r3.l     | 500GB  | 64    | None        | 100GB       |
| r3.xl    | 1000GB | 128   | None        | 100GB       |

\*\*g3.l is the default flavor. <br>
[Click to see the approximate (delayed 5 minutes) count of available resources on JS2](https://docs.jetstream-cloud.org/overview/status/#availability-of-scarce-resources)

## MorphoCloud Commands

| Command            | Description                                                                             | Who can run          |
| ------------------ | --------------------------------------------------------------------------------------- | -------------------- |
| `/shelve`          | Shelve (turn off) the instance.                                                         | Issue creator, Admin |
| `/unshelve`        | Unshelve (turn on) the instance.                                                        | Issue creator, Admin |
| `/encode_email`    | Update issue description obfuscating emails.                                            | Issue creator, Admin |
| `/decode_email`    | Update issue description deobfuscating emails.                                          | Issue creator, Admin |
| `/email`           | Send email to _Issue creator_ with connection URL (only possible if instance is active) | Issue creator, Admin |
| `/renew`           | Extend the instance lifespan if additional time is available.                           | Issue creator, Admin |
| `/create`          | Approve the request and then e the instance and the volume.                             | Admin                |
| `/delete_instance` | Delete the instance.                                                                    | Admin                |
| `/delete_volume`   | Delete the storage volume.                                                              | Admin                |
| `/delete_all`      | Delete the instance and volume.                                                         | Admin                |

## Ready to give a try?

Go to https://github.com/MorphoCloud/MorphoCloudInstances/issues/new/choose,
click **Get Started** and fill in the issue template and choose your instance
flavor. Your request will be approved within 24h (often faster).

## MorphoCloud Desktop Interface

- **A:** Side toolbar that gets activated by pressing the `CTRL (or CMD)` +
  `ALT` + `SHIFT` keys. It allows copy/paste into the remote session, browse and
  download files on the remote drive and adjust screen zoom levels (cut from the
  screenshot).
- **B:** Shortcuts to commonly used applications and to **MyData** storage
  volume.

- **C:** Displays list of available applications (searchable)

- **D:** Right mouse clicking anywhere on desktop brings this menu, including
  changing screen resolution (Display settings).

- **E:** Click on this icon anytime to extend your session for additional 4
  hours.

<p align="center">
  <img src="https://github.com/MorphoCloud/MorphoCloudInstances/blob/main/MCI_Desktop.png" />
</p>

## MorphoCloud Instances performance and troubleshooting common issues

- While the web browser based connection to MorphoCloud instances is the most
  convenient way, its performance may vary. Particularly if you are a using
  high-resolution monitor, application and desktop scaling might be less than
  ideal. For better performance, we suggest using the dedicated **TurboVNC
  client**, which is freely available at
  https://github.com/TurboVNC/turbovnc/releases. Then, choose the appropriate
  executable for your operating system. Once the TurboVNC is installed, you can
  connect to your running instance using the convention: **W.X.Y.Z:1**, where
  W.X.Y.Z is the IP address of the instance provided in the email. You will use
  the same passphrase as the connection password. You can also check the email
  sent by the MorphoCloudPortal for more instructions on using TurboVNC.

- If the 3D rendering performance appears slow, you need to make sure: (1) 3D
  Slicer is actually using the GPU, and (2) GPU on the instance is function. For
  the first issue, make sure you are always launching the Slicer from the
  shortcut on the desktop. For the latter, open a terminal window and type the
  command `nvidia-smi`. This should list the GPU in your system, its driver and
  CUDA version, along with the applications using it (e.g., if Slicer is
  running, it should be listed). If there is any error, please copy and paste
  the full screenshot and notify us. Sometimes rebooting the system from the
  command line via the command `sudo reboot`, helps clear the issue.

## Funding & Acknowledgement

MorphoCloud services, including MorphoCloud OnDemand Instances, are supported by
funding from National Science Foundation (DBI/2301405) and National Institutes
of Health (NICHD/HD104435). MorphoCloud runs on cyberinfrastructure that is made
available by current and previous funding from by National Science Foundation
(Jetstream2: OAC/2005506, Exosphere: TI/2229642). Initial development of
SlicerMorph was previously supported by National Science Foundation
(DBI/1759883).

If you use any of the MorphoCloud services for your project, please acknowledge
our funders with this statement:

“This study relied on cyberinstructure supported by grants from National Science
Foundation (MorphoCloud: DBI/2301405; JetStream2: OAC/2005506; Exosphere:
TI/2229642) and National Institutes of Health (MorphoCloud: NICHD HD104435).”
