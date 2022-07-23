#!/usr/bin/env bash
#
# Set personal Gnome defaults
#
gsettings set org.gnome.desktop.background picture-options "zoom"
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>h']"
gsettings set org.gnome.desktop.wm.keybindings move-to-center "['<Super><Control>c']"
gsettings set org.gnome.mutter center-new-windows "true"
gsettings set org.gnome.shell.extensions.pop-shell activate-launcher "['<Super>slash', '<Super>space']"
