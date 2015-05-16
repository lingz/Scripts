#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
parentdir="$(dirname "$DIR")"

apt-get install xclip

# copy clipboard feature

ln -s $parentdir/linked/urxvt-clipboard /usr/lib/urxvt/perl/clipboard
apt-get install rxvt-unicode
