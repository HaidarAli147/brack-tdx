# Append TDX v6: offline compatibility update

This opt-in update is for already installed Append TDX desktops using the **custom GTK taskbar**, not tint2.

Intended behaviors:
- taskbar flush with the bottom edge of the monitor
- terminal content inset by 32px while the taskbar is enabled
- one Openbox workspace
- `/lock` using i3lock and the normal Linux password

The ZIP distributed in ChatGPT includes the guarded `patch.py` compatibility installer and lock background. The source-side companion scripts are tracked here. The patch must be tested with the specific installed `append-desktop` and `append-taskbar`, which can vary after prior offline patches. A successful syntax check is **not** a successful GUI test.

For password locking: `sudo apt install i3lock`. Never disable password login. Keep a working Budgie fallback. `/lock` requires the bashrc function to be installed.

**Release status:** beta, not hardware-verified. Do not claim fullscreen/taskbar fixed without testing on the target Dell. The existing v0.6.0 archived downloadable ZIP on appendhub.com is a separate older release.