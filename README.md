# Brack TDX

**Brack Terminal Desktop** is an experimental terminal-first Linux desktop session powered by Bash, Kitty and Openbox. Normal terminal commands work while graphical apps open and remain manageable.

## v0.6 beta features

- `ls -rr`: list graphical application names.
- `-rr APP NAME`: open a GUI application without blocking the shell.
- `u -rr APP NAME`: preview uninstall and confirm before removing.
- `brack-tabs` / `brack-switch`: view and activate application windows.
- Minimized-window icon bar, terminal color schemes, and session launcher.
- `brack-update`: check GitHub Releases and verify a release ZIP's SHA-256 checksum before asking to install it.

## Install on Debian 13

Download `brack-terminal-desktop-v0.6-updater.zip` from the repository files and save it to `~/Downloads`.

```bash
sudo apt install --no-install-recommends kitty openbox libgtk-3-bin python3 python3-gi gir1.2-gtk-3.0 wmctrl x11-utils unzip
cd ~/Downloads
unzip brack-terminal-desktop-v0.6-updater.zip
cd brack-terminal-desktop
bash install.sh
```

Log out, choose **Brack Terminal** from the SDDM session selector, then log in. Keep your old desktop installed for recovery.

Configure future release checks:

```bash
brack-update --repo HaidarAli147/brack-tdx
brack-update --check
```

**Release requirements:** GitHub Releases must include a versioned ZIP named `brack-terminal-desktop-vX.Y.Z.zip` plus an accompanying `.sha256` asset. Committing a ZIP to the repository alone does not create a release or enable updates.

**Beta warning:** This is a custom desktop session, not a complete operating system. Review scripts before installing; graphics and session behavior have not been verified on multiple machines. Checksums verify download integrity, not publisher authenticity.

License and required third-party notices should be reviewed before a stable public release.
