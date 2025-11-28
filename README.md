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

**NOTE:** MorphoCloud and JetStream2 are designed for open science and public data; it is NOT compliant with high-security federal privacy regulations such as HIPAA or FERPA. Consequently, users are strictly prohibited from uploading, processing, or storing any data containing Personally Identifiable Information or Protected Health Information. 

## Available Instance Types

| Flavor | RAM    | Cores | GPU         | Storage | Use Cases |
| ------ | ------ | ----- | ----------- | ------- | --------- | 
| g3.l\* | 60GB   | 16    | A100 (20GB) | 100GB   | General purpose morphology and morphometrics |
| g3.xl  | 125GB  | 32    | A100 (40GB) | 100GB   | Photogrammetry, NNInteractive |
| m3.x   | 250GB  | 64    | None        | 100GB   | Computationally intense tasks that don't require GPU; eg., Image registration with ANTsPy |
| r3.l   | 500GB  | 64    | None        | 100GB   | Image registration with larger dataset |
| r3.xl  | 1000GB | 128   | None        | 100GB   | Image registration with larger dataset |

\*`g3.l` is the default instance and is usually more available than other instance flavors.<br>

[Click to see the approximate (delayed 5 minutes) count of available resources on JS2](https://docs.jetstream-cloud.org/overview/status/#availability-of-scarce-resources)

## Ready to give a try?

* **Individual users:** Go to https://github.com/MorphoCloud/MorphoCloudInstances/issues/new?template=instance-request.yml, fill in the necessary information and choose your instance flavor. Your request will be approved within 24h (often faster). Then, you can create and start using your instance. 

* **Workshop or Short-Course organizers:** If you are planning an event (5 days or less) in which participants would need access to MorphoCloud throughout the 
event, you can fill in the [Workshop Request](https://github.com/MorphoCloud/MorphoCloudInstances/issues/new?template=workshop-request.yml). Please do that at least 2 weeks prior to your planned event. We will get back to you with the necessary instructions on how to setup your environment. 
 
## MorphoCloud Commands

Once your request is approved you can use these commands to manage your
instance.

| Command            | Description                                                                                                        | Who can run          |
| ------------------ | ------------------------------------------------------------------------------------------------------------------ | -------------------- |
| `/create`          | Create the instance (and the storage volume if not present already).                                               | Issue creator, Admin |
| `/shelve`          | Shelve (turn off) a running instance.                                                                              | Issue creator, Admin |
| `/unshelve`        | Unshelve (turn on) a stopped instance.                                                                             | Issue creator, Admin |
| `/delete_instance` | Delete the instance (e.g. when it is unresponsive, then you can use the `/create` to recreate the instance afresh. | Issue creator, Admin |
| `/delete_volume`   | Delete the storage volume. (Beware you will loose all the existing data)                                           | Issue creator, Admin |
| `/encode_email`    | Update issue description obfuscating emails.                                                                       | Issue creator, Admin |
| `/decode_email`    | Update issue description deobfuscating emails.                                                                     | Issue creator, Admin |
| `/email`           | Resend email to _Issue creator_ with connection URL (only possible if instance is active)                          | Issue creator, Admin |
| `/renew`           | Extend the instance lifespan one-time.                                                                             | Issue creator, Admin |

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

## MorphoCloud Instances FAQ for common issues

- After I login to the instance, **only a black background and the mouse pointer
  is visible**. This is due to a known race condition. Connect to your instance
  from the command line using the SSH instructions and type these two commands
  to fix it:

```
sudo systemctl disable gdm
sudo reboot now
```

then wait a couple minutes for your instance to reboot and become online, and
then retry connecting from GUI.

- **Cursor is laggy, and there is high latency in UI (not just Slicer, all
  windows are slow to refresh):** This is due to limited bandwidth of your
  network connection. If you can try, switching to a different network. Also for
  better performance, we suggest using the dedicated **TurboVNC client**, which
  is freely available at https://github.com/TurboVNC/turbovnc/releases. TurboVNC
  allows you to reduce the quality of the desktop image so that less bandwidth
  is used when refreshing the screens. Once the TurboVNC is installed, you can
  connect to your running instance using the convention: **W.X.Y.Z:1**, where
  W.X.Y.Z is the IP address of the instance provided in the email. You will use
  the same passphrase as the connection password. You can also check the email
  sent by the MorphoCloudPortal for more instructions on using TurboVNC.

- **Instance GUI doesn't scale correctly (i.e., fonts too small/large):** Try
  using **TurboVNC** client for connecting to the instance. TurboVNC handles the
  high-resolution DPI scaling and resizing the application window much better
  than the web browser connections.

- **3D rendering performance of Slicer appears slow:**, You need to make sure:
  (1) 3D Slicer is actually using the GPU, and (2) GPU on the instance is
  functional. For the first issue, make sure you are always launching the Slicer
  from the shortcut on the desktop. For the latter, open a terminal window and
  type the command `nvidia-smi`. This should list the GPU in your system, its
  driver and CUDA version, along with the applications using it (e.g., if Slicer
  is running, it should be listed). If there is any error, please copy and paste
  the full screenshot and notify us. Sometimes rebooting the system from the
  command line via the command `sudo reboot`, helps clear the issue.
- **I checked, but 3D rendering performance of Slicer still very slow, application window is unresponsive:** Try to stop volume rendering (turn it off). See if any dimension of the your volume is equal to or greater than 4096 voxels. If so, use CropVolume module in Slicer to downsample those dimensions to 4095 or less. Note that this appears to be a specific problem with the drivers provided on the MorphoCloud host (JetStream2), and does not happen in other systems.

## Funding & Acknowledgement

MorphoCloud services, including MorphoCloud On-Demand Instances, are supported
by funding from the National Science Foundation (DBI/2301405) and National
Institutes of Health (NICHD/HD104435). MorphoCloud runs on cyberinfrastructure
that is made available by current and previous funding from the National Science
Foundation (JetStream2: OAC/2005506, Exosphere: TI/2229642). Initial development
of SlicerMorph was previously supported by National Science Foundation
(DBI/1759883).

If you use any of the MorphoCloud services for your project, please acknowledge
our funders with this statement:

> This study relied on cyberinfrastructure supported by grants from the National
> Science Foundation (MorphoCloud: DBI/2301405; JetStream2: OAC/2005506;
> Exosphere: TI/2229642) and the National Institutes of Health (MorphoCloud:
> NICHD HD104435).
