#!/bin/sh
#
# safe and secure install script.

download() {
    url="https://raw.githubusercontent.com/yrwq/yth"

    script="${url}/master/yth.sh"
    colors="${url}/master/colors"
    templates="${url}/master/templates"

    mkdir -p ~/.local/share/yth

    curl "$script" > ~/.bin/yth || {
        printf '%s\n' "error: Couldn't download yth." >&2
        exit 1
    }

    curl "$colors" > ~/.local/share/yth/colors || {
        printf '%s\n' "error: Couldn't download colors." >&2
        exit 1
    }

    curl "$templates" > ~/.local/share/yth/templates || {
        printf '%s\n' "error: Couldn't download templates." >&2
        exit 1
    }
}

main() {
    download
    chmod +x ~/.bin/yth
    printf '%s\n' "Installation complete. Run yth in your terminal."
}

main "$@"

