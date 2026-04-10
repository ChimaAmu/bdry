#!/bin/bash
# Adds specified information into a time-formatted diary entry

usage() {
    echo "Usage: $(basename "$0") -a {data} to add to current day
       $(basename "$0") -d {line} to delete line
       $(basename "$0") -p to print current day entry"
    exit 0
}

case $1 in 
    -a | -add )
        shift;
        today="$(date +%Y%m%d)"
        if [ ! -f "$today" ] ;
        then
            touch "$today"
            date +%A,_%dth_%B_%Y | sed s/_/\ /g > "$today"
            echo "------------------------------" >> "$today"
        fi
        echo "$(date +%T)" "$@" >> "$(date +%Y%m%d)"
        exit 0
        ;;
    -d | -delete )
        sed -i "$2"'d' "$(date +%Y%m%d)"
        exit 0
        ;;
    -p | -print )
        if [ "$2" = "number" ] || [ "$2" = "num" ] || [ "$2" = "n" ]; then
            cat -n "$(date +%Y%m%d)"
            exit 0
        fi
        cat "$(date +%Y%m%d)"
        exit 0
        ;;
    -h | * )
        usage
        ;;
esac
