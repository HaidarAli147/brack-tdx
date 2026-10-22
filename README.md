# Append TDX

**Append TDX**, by **Append Hub**, is an experimental **X11 terminal-first Linux desktop session** for Debian 13. It uses Bash, Kitty and Openbox. It is a separate desktop session, not a new Linux kernel or distribution.

This project was previously called **Brack TDX**. Existing helper commands with `brack-` prefixes remain available for compatibility while the project transitions.

## Append Capture (new)

Inside **Append TDX**:

| Shortcut | Action |
| --- | --- |
| `Prt Sc` | Open Flameshot screenshot selection/annotation interface |
| `Shift + Prt Sc` | Open area selection/annotation |
| `Alt + Prt Sc` | Save a screenshot of the focused window |
| `Ctrl + Prt Sc` | Save a screenshot of the entire desktop |

Screenshot editor supports drawing/annotation, copying and saving via Flameshot. Captures are saved to **Pictures/Screenshots** by default, or a directory specified by `APPEND_CAPTURE_DIR`. `append-capture gui`, `append-capture full`, and `append-capture window` also work in the terminal. The full and window shortcuts save PNG files without displaying an editor. Window capture uses `scrot -u` on X11.

The shortcuts are defined only for the **Append TDX Openbox session** through a generated private Openbox configuration. They do not modify global Budgie shortcuts. The generated configuration copies the system Openbox defaults on each TDX session start; any old `~/.config/openbox/rc.xml` customizations are not imported.

## Updating TDX with one command

After installing this updater once, open the terminal inside Append TDX and type:

```bash
update tdx
```

Append TDX checks the repository's **main** branch, downloads its newest source, shows the target commit, asks permission, and runs the installer only after confirmation. A logout/login loads the desktop updates. An internet connection and Git are required. Your previous Budgie session remains available.

This is a **source-based Git updater**, not the old GitHub Release ZIP updater. It trusts the Append TDX repository, so review changes before accepting major updates. For testing a different development branch, an advanced user may set `APPEND_TDX_UPDATE_BRANCH` explicitly. The initial installation is still required once to add the update command.

## Install on Debian 13

Review `install.sh` before execution:

```bash
sudo apt update
sudo apt install --no-install-recommends git kitty openbox libgtk-3-bin python3 python3-gi gir1.2-gtk-3.0 wmctrl x11-utils xdg-user-dirs flameshot scrot network-manager wireplumber tint2 brightnessctl bluez
git clone https://github.com/HaidarAli147/brack-tdx.git
cd brack-tdx
git switch feature/append-tdx-one-command-update
bash install.sh
```

Log out, then select **Append TDX** in your SDDM session chooser. Your previous desktop remains installed.

If you have already cloned the repository, run `git fetch origin` and `git switch feature/append-tdx-system-controls` instead of cloning again.

## Terminal-native system controls (development branch)

Inside the **Append TDX** terminal (not regular Budgie Bash), run:

| Command | Function |
| --- | --- |
| `/settings` | Open the interactive text-only settings menu |
| `/wifi` | Show nearby networks, connect, disconnect, toggle radio |
| `/volume status` | Show default output volume |
| `/volume up`, `/volume down`, `/volume mute`, `/volume 40` | Change volume |
| `/brightness status`, `/brightness up`, `/brightness 50` | Control laptop brightness if supported |
| `/bluetooth` | Open `bluetoothctl` |
| `/taskbar add`, `/taskbar remove`, `/taskbar status` | Enable or disable optional tint2 taskbar |
| `/screenshot`, `/screenshot full`, `/screenshot window` | Screenshot commands |
| `/help` | Show all slash commands |

Commands beginning with `/` are **Bash functions** loaded into the Append TDX interactive terminal session. They are not global Linux executables.

**Wi-Fi:** NetworkManager must be running, and the user must have authorization. Network passwords are requested interactively by `nmcli --ask` and are not included in process command lines.

**Audio:** `wpctl` requires a running PipeWire/WirePlumber session. **Brightness:** permissions and hardware support vary by device. **Taskbar:** tint2 is an optional bar, not a requirement for terminal-based operation; enabling it is remembered for your next TDX session. These features have not yet been tested on the user's hardware.

## Desktop commands

- `ls -rr` lists graphical apps.
- `-rr APP NAME` launches an app without blocking Bash.
- `u -rr APP NAME` previews and confirms app removal.
- `brack-tabs`, `brack-switch`, `brack-color`, and `brack-update` are legacy commands retained for compatibility.
- `exit` ends the terminal session.

## Implementation notes

The current compositor is **Openbox on X11**, not Wayland. An X11 screenshot helper cannot simply be reused in Wayland without compositor-specific protocols or desktop portals. Screenshot capture may reveal private information, so share only screenshots you intend to share.

**Status: experimental development branch.** The code has not yet been graphically tested on the target Debian installation. Test the new session with your existing desktop available as a fallback. No changes are made to your default desktop. GitHub repository renaming is separate from in-app branding.

## Laptop screenshot and volume key bindings (fix branch)

Append TDX's private Openbox session now registers `Print`, `XF86AudioRaiseVolume`, `XF86AudioLowerVolume`, `XF86AudioMute`, `XF86AudioMicMute`, `XF86MonBrightnessUp`, and `XF86MonBrightnessDown` keys. `append-media` handles the hardware volume buttons using `wpctl` or `pactl`; brightness uses `brightnessctl`. The screenshots use `append-capture`, which now starts Flameshot's service when required.

**Install this branch to test**:
```bash
cd ~/Downloads
git clone -b fix/append-tdx-media-and-capture-keys https://github.com/HaidarAli147/brack-tdx.git append-tdx-key-fix
cd append-tdx-key-fix
bash install.sh
```
Then log out and log in to **Append TDX** again (not Budgie).

**Diagnose if a key still fails inside TDX**:
```bash
append-media volume-up
append-capture gui
xev -event keyboard
```
Focus the `xev` window, press the keyboard's volume or Print key, and check its `keysym` name. Laptop Fn settings can change which key event Openbox receives. If `append-media` fails, inspect `wpctl status` and `systemctl --user status pipewire wireplumber`. If `append-capture gui` fails, run `flameshot gui` to see the error. This update changes **TDX shortcuts only**, not Budgie or system-wide keyboard mapping.

These changes are committed but still require testing on the physical Debian machine.
