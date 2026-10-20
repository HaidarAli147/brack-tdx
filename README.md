# Brack TDX

**Brack Terminal Desktop (Brack TDX)** is an experimental terminal-first Linux desktop session for Debian 13, built with Bash, Kitty and Openbox. You can run normal shell commands while launching and managing graphical applications.

## Commands

- `ls -rr` — list graphical applications available to launch.
- `-rr Brack Code Studio` — launch an app without blocking the Bash prompt.
- `u -rr APP NAME` — simulate, preview and confirm application removal.
- `brack-tabs` / `brack-switch 1` — list and focus graphical windows.
- `brack-color list` / `brack-color royal` — choose a terminal theme.
- `brack-update --check` — check for a newer GitHub Release.
- `exit` — ends the Brack terminal session.

Minimized windows are displayed in a temporary icon bar. Other desktops remain installed and selectable from SDDM.

## Install from the source repository (Debian 13)

Review the files, especially `install.sh`, before running:

```bash
sudo apt update
sudo apt install --no-install-recommends git kitty openbox libgtk-3-bin python3 python3-gi gir1.2-gtk-3.0 wmctrl x11-utils unzip
git clone https://github.com/HaidarAli147/brack-tdx.git
cd brack-tdx
bash install.sh
```

Then log out, select **Brack Terminal** from SDDM and sign in. You can return to Budgie or another existing session.

## Configure update checks

```bash
brack-update --repo HaidarAli147/brack-tdx
brack-update --check
```

**Important:** Uploading source code to GitHub is not the same as publishing a release. The updater requires an actual GitHub Release with a tag such as `v0.7.0`, an asset named `brack-terminal-desktop-v0.7.0.zip`, and `brack-terminal-desktop-v0.7.0.zip.sha256`. Until such a release exists, update checks will report no release. A SHA-256 checksum helps detect corruption but does not independently authenticate the publisher.

## Status and cautions

**v0.6 beta.** This is a custom desktop session, not a standalone Linux distribution. It has not yet been tested across different machines or security-audited. Normal GUI applications still appear in separate managed windows. Keep your previous desktop as a fallback. Review the package removals proposed by `u -rr` before confirming.

License selection and third-party notices should be reviewed before a stable release.
