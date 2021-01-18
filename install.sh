#!/bin/sh
#
# safe and secure install script.

download() {
    url="https://github.com/yrwq/yth"

    mkdir -p ~/.local/share/yth

    git clone $url && cd yth

    cp yth.sh ~/.bin/yth

    cp colors ~/.local/share/yth/colors -r

    cp templates ~/.local/share/yth/templates -r

}

main() {
    download
    chmod +x ~/.bin/yth
    cd .. &&  rm -rf yth
    printf '%s\n' "Installation complete. Run yth in your terminal."
}

main "$@"

