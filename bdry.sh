#!/bin/bash

usage() {
    echo "Usage: $(basename "$0") -a {data} to add to current day"
    exit 0
}

case $1 in 
    -a | -add )
        shift;
        echo "$(date +%T)" "$@" >> "$(date +%Y%m%d)"
        exit 0
        ;;
    -d | -delete )
        sed -i "$2"'d' "$(date +%Y%m%d)"
        exit 0
        ;;
    -p | -print )
        cat -n "$(date +%Y%m%d)"
        exit 0
        ;;
esac
