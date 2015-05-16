#!/bin/bash

echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" >> /etc/apt/sources.list
apt-get update
apt-get --allow-unauthenticated install sur5r-keyring
apt-get update
apt-get install i3
apt-get install dmenu
apt-get install i3status
apt-get install rxvt-unicode

# Copy the clipboard tool

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentdir="$(dirname "$DIR")"

apt-get install xclip
ln -s $parentdir/linked/urxvt-clipboard /usr/lib/urxvt/perl/clipboard
