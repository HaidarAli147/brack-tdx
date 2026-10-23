# Append TDX by Append Hub

**Append TDX** is an experimental terminal-first **X11 desktop session** for Debian 13. Openbox manages application windows while a dedicated GTK3/VTE terminal surface occupies the desktop layer. It is not a standalone operating system or Linux distribution.

## Open system settings and Wi-Fi

Type these commands in the **Append TDX terminal** after choosing the Append TDX login session:

| Command | Action |
|---|---|
| `/settings` | Open the terminal-based system settings menu |
| `/wifi` | Manage Wi-Fi, scan nearby networks, connect with a password and disconnect |
| `/taskbar add` | Enable the optional purple application taskbar |
| `/taskbar remove` | Disable the optional taskbar |
| `/taskbar status` | Check whether the taskbar is enabled |
| `/volume up`, `/volume down`, `/volume mute` | Volume controls |
| `/brightness up`, `/brightness down` | Hardware brightness if supported |
| `/bluetooth` | Open terminal Bluetooth controls |
| `/screenshot` | Start screenshot selection and annotation |
| `update tdx` | Check for and install a GitHub source update with confirmation |
| `append-tabs` | List regular application windows |
| `append-switch NUMBER` | Switch to an application window |
| `ls -rr` | List installed graphical apps |
| `-rr APPLICATION` | Launch a graphical app |

The slash-prefixed commands are **Bash functions loaded by the Append TDX shell**, not executables available in arbitrary system terminals.

The optional taskbar uses tint2. It includes an application list, clock and notification tray. When the optional taskbar is disabled, no minimized-window popup is shown. Taskbar settings persist between sessions.

## Screenshot and media keys

Inside the Append TDX Openbox session, `PrtSc` launches Flameshot. `Shift+PrtSc` selects an area, `Alt+PrtSc` captures a window, and `Ctrl+PrtSc` captures the whole screen. Hardware volume and brightness bindings also run in the TDX session. These are still hardware-dependent and require testing on each laptop.

## Install

Review `install.sh` first. From Debian:

```bash
sudo apt update
sudo apt install git openbox libgtk-3-bin python3 python3-gi gir1.2-gtk-3.0 gir1.2-vte-2.91 wmctrl x11-utils xdotool xdg-user-dirs flameshot scrot network-manager wireplumber tint2 brightnessctl bluez
git clone https://github.com/HaidarAli147/brack-tdx.git
cd brack-tdx
bash install.sh
```

The GitHub repository URL retains its existing slug for now; the desktop product and installed commands use **Append Hub** branding. Renaming the repository itself requires a separate GitHub repository settings change.

Log out, select **Append TDX** in your login screen, and sign in. Keep your existing GNOME or Budgie session installed as a recovery option.

For subsequent updates, type `update tdx` inside Append TDX. This updater checks the repository `main` branch and asks for confirmation before running the installer.

**Status: experimental.** Test login, screenshots and media keys on physical hardware before relying on this as your only desktop.

## Wallpaper and app categories

Use `/background set ~/Pictures/wallpaper.jpg` to select a desktop wallpaper, `/background clear` to restore the purple background, or `/background status` to see your selection. Re-enter the Append TDX session to refresh the background. The image renders behind an inset terminal panel to preserve terminal legibility.

Use `ls -rr CATEGORY` to list installed applications by their desktop-file categories, for example `ls -rr Game`, `ls -rr Education`, or `ls -rr Office`. Use `ls -rr categories` to see available category labels. Apps without appropriate Categories metadata may not appear under a filter.

## Terminal color themes

Inside Append TDX, choose a preset:
```bash
/theme mint
/theme royal
/theme amethyst
/theme mono
/theme light
```

For personal colors, use three quoted HEX codes (background, text, accent):
```bash
/theme custom '#112233' '#E0FFF0' '#55CCAA'
```

Run `/theme list` for presets or `/theme status` to inspect saved colors. The setting persists and is shared by the integrated VTE desktop terminal, header and optional tint2 taskbar. Log out and back into Append TDX to apply a changed theme. Wallpaper selection remains independent.
