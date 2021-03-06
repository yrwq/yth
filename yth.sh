#!/usr/bin/env bash

# yth
# Author: yrwq
# Version: 0.2

# Requires fzf, wmctrl, libnotify and feh

theme_dir="$HOME/.local/share/yth/colors"
template_dir="$HOME/.local/share/yth/templates"

# Define which templates to use
# Available templates:
# zathura, xresources, discord, rofi
config=("zathura" "xresources" "discord" "rofi")

has(){
    command -v "$1" &> /dev/null
}

err(){
    printf "${c_red}%s${c_reset}" "$*" >&2
}

die(){
    [[ -n "$1" ]] && err "$1"
    exit 1
}

# Check dependencies
has wmctrl || die "wmctrl not found"
has feh || die "feh not found"
has notify-send || die "notify-send not found"
has fzf || die "fzf not found"

# Arguments
while [ "$1" ]; do
    case "$1" in
        -t|--theme) theme="$2"; shift 2 ;;
        *) break ;;
    esac
done

# Get a list of themes
themes="$(ls -1 $theme_dir)"

# Choose a theme
[ "$theme" ] || theme="$(printf %b "$themes" | fzf)"

# Handling theme
[ -f "$theme_dir/$theme" ] &&
    echo "curr=$theme_dir/$theme" > $HOME/.cache/current-color &
    . $theme_dir/$theme ||
    { echo "Invalid theme, exiting"; exit 1; }

# Run templates defined in config
for val in ${config[*]}; do
    sh $template_dir/$val.template
done

# Apply xresources
xrdb $HOME/.Xresources

# Change wallpapere if given
if [ $wall ]; then
    feh --bg-fill --no-fehbg $wall
fi

# Restart window manager
sleep 1
wait
_wm=$(wmctrl -m | grep "Name:" | awk '{print $2}')
case $_wm in
    awesome)
        _running=$(pidof awesome)
        [ $_running ] && echo 'awesome.restart()' | awesome-client
    ;;
    bspwm)
        _running=$(pidof bspwm)
        [ $_running ] && bspwm restart
    ;;
esac
