#!/bin/bash
# swaps opt and cmd
echo "1" > /sys/module/hid\_apple/parameters/swap\_opt\_cmd
# enables tilde
echo 0 > /sys/module/hid_apple/parameters/iso_layout
# enables fn keys
echo "0" > /sys/module/hid_apple/parameters/fnmode
