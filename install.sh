#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
for prog in kitty openbox gtk-launch python3 wmctrl xprop flameshot scrot; do
  command -v "$prog" >/dev/null 2>&1 || { echo "Missing $prog. Install: sudo apt install kitty openbox libgtk-3-bin python3 python3-gi gir1.2-gtk-3.0 wmctrl x11-utils flameshot scrot xdg-user-dirs" >&2; exit 1; }
done
python3 -c "import gi; gi.require_version('Gtk', '3.0'); from gi.repository import Gtk" || { echo "Missing python3-gi / GTK3 bindings." >&2; exit 1; }
mkdir -p "$HOME/.local/bin" "$HOME/.config/append-tdx" "$HOME/.config/brack-terminal"
# Keep older helper names installed to preserve existing commands and user preferences.
for name in -rr u brack-update brack-color brack-windows brack-minibar; do
  install -m 755 "bin/$name" "$HOME/.local/bin/$name"
done
install -m 755 bin/append-capture "$HOME/.local/bin/append-capture"
install -m 755 bin/append-openbox-config "$HOME/.local/bin/append-openbox-config"
install -m 644 config/append-bashrc "$HOME/.config/append-tdx/bashrc"
if [ ! -f "$HOME/.config/append-tdx/kitty.conf" ]; then
  if [ -f "$HOME/.config/brack-terminal/kitty.conf" ]; then
    cp "$HOME/.config/brack-terminal/kitty.conf" "$HOME/.config/append-tdx/kitty.conf"
  else
    printf 'background #210D34\nforeground #F3E8FF\ncursor #B68AFF\nfont_size 13.0\n' > "$HOME/.config/append-tdx/kitty.conf"
  fi
fi
install -m 644 VERSION "$HOME/.config/append-tdx/version"
"$HOME/.local/bin/append-openbox-config"
sudo install -m 755 bin/append-tdx-session /usr/local/bin/append-tdx-session
printf '[Desktop Entry]\nName=Append TDX\nComment=Append Hub terminal-first X11 desktop\nExec=/usr/local/bin/append-tdx-session\nType=Application\nDesktopNames=APPEND\n' | sudo tee /usr/share/xsessions/append-tdx.desktop >/dev/null
# Only remove our exact legacy launcher entry, not any other session.
if [ -f /usr/share/xsessions/brack-terminal.desktop ] && grep -q '^Exec=/usr/local/bin/brack-terminal-session$' /usr/share/xsessions/brack-terminal.desktop; then
  sudo rm /usr/share/xsessions/brack-terminal.desktop
fi
echo 'Append TDX installed. Select Append TDX at the login screen.'
echo 'Screenshot: PrtSc = editor, Shift+PrtSc = select area, Alt+PrtSc = active window, Ctrl+PrtSc = full screen.'
