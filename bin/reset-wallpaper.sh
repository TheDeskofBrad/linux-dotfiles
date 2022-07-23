#!/usr/bin/env bash
#
###########################################################
# Based on script originally written by Serg Kolo
# Link: http://askubuntu.com/q/744464/295286
###########################################################
#
ARGV0="$0"
ARGC=$#
change_background()
{
    FILE="$(readlink -f "$1" )"
    echo changing to "$FILE"
    if [ -v "GNOME_SHELL_SESSION_MODE" ]
    then
        gsettings set org.gnome.desktop.background picture-uri-dark "file://$FILE"
    else
        feh --bg-scale "$FILE"
    fi
}

make_list()
{
  find "$1" -maxdepth 1 -type f > "$2"
}

main()
{
  # Variables
  local DISPLAY=:0 # ensure this is set
  local DIR="$HOME/.config/wallpaper/"
  local LIST="/tmp/wallpaper.list"
  local TIME="$2"
  until [ -d "$DIR" ]
  do
    sleep 5
  done
  make_list "$DIR" "$LIST"
  random_wallpaper=$( shuf $LIST | head -n 1 )
  change_background "$random_wallpaper"
}

main "$@"
