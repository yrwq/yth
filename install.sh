#!/bin/sh
#
# safe and secure install script.

download() {
    url="https://raw.githubusercontent.com/yrwq/yth"
    url="${url}/master/yth.sh"

    curl "$url" > ~/yth.sh || {
        printf '%s\n' "error: Couldn't download yth." >&2
        exit 1
    }
}

main() {
    download

    printf '%s\n' "Installation complete."
}

main "$@"

