#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
for prog in git openbox gtk-launch python3 wmctrl xprop xdotool flameshot scrot nmcli wpctl tint2; do
  command -v "$prog" >/dev/null 2>&1 || { echo "Missing $prog. Install: sudo apt install openbox libgtk-3-bin python3 python3-gi gir1.2-gtk-3.0 wmctrl x11-utils xdotool gir1.2-vte-2.91 flameshot scrot xdg-user-dirs network-manager wireplumber tint2 brightnessctl bluez" >&2; exit 1; }
done
python3 -c "import gi; gi.require_version('Gtk', '3.0'); gi.require_version('Vte', '2.91'); from gi.repository import Gtk, Vte" || { echo "Missing python3-gi / GTK3 bindings." >&2; exit 1; }
mkdir -p "$HOME/.local/bin" "$HOME/.config/append-tdx"
for name in -rr u append-windows; do
  install -m 755 "bin/$name" "$HOME/.local/bin/$name"
done
# Clean up obsolete popup and older helper executables installed by TDX.
for old in append-minibar brack-windows brack-minibar brack-color brack-update; do
  if [ -f "$HOME/.local/bin/$old" ]; then
    mv -n "$HOME/.local/bin/$old" "$HOME/.local/bin/$old.tdx-backup"
  fi
done
install -m 755 bin/append-tdx-update "$HOME/.local/bin/append-tdx-update"
install -m 755 bin/append-wallpaper "$HOME/.local/bin/append-wallpaper"
install -m 755 bin/append-control "$HOME/.local/bin/append-control"
install -m 755 bin/append-media "$HOME/.local/bin/append-media"
install -m 755 bin/append-desktop "$HOME/.local/bin/append-desktop"
install -m 755 bin/append-desktop-window "$HOME/.local/bin/append-desktop-window"
install -m 755 bin/append-taskbar-config "$HOME/.local/bin/append-taskbar-config"
install -m 755 bin/append-capture "$HOME/.local/bin/append-capture"
install -m 755 bin/append-openbox-config "$HOME/.local/bin/append-openbox-config"
install -m 644 config/append-bashrc "$HOME/.config/append-tdx/bashrc"
install -m 644 VERSION "$HOME/.config/append-tdx/version"
"$HOME/.local/bin/append-openbox-config"
"$HOME/.local/bin/append-taskbar-config"
sudo install -m 755 bin/append-tdx-session /usr/local/bin/append-tdx-session
printf '[Desktop Entry]\nName=Append TDX\nComment=Append Hub terminal-first X11 desktop\nExec=/usr/local/bin/append-tdx-session\nType=Application\nDesktopNames=APPEND\n' | sudo tee /usr/share/xsessions/append-tdx.desktop >/dev/null
echo 'Type /settings or /wifi in the Append TDX terminal; /taskbar add enables the optional taskbar.'
echo 'Future updates: type update tdx inside the Append TDX terminal.'
echo 'Append TDX installed. Select Append TDX at the login screen.'
echo 'Screenshot: PrtSc = editor, Shift+PrtSc = select area, Alt+PrtSc = active window, Ctrl+PrtSc = full screen.'
