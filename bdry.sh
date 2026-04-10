#!/bin/bash
# Adds specified information into a time-formatted diary entry

usage() {
    echo "Usage: $(basename "$0") -a {data} to add to current day
       $(basename "$0") -d {line} to delete line
       $(basename "$0") -p to print current day entry"
    exit 0
}

today="$(date +%Y%m%d)"
case $1 in 
    -a | -add )
        shift;
        if [ ! -f "$today" ] ;
        then
            touch "$today"
            date +%A,_%dth_%B_%Y | sed s/_/\ /g > "$today"
            echo "------------------------------" >> "$today"
        fi
        echo "$(date +%T)" "$@" >> "$today"
        exit 0
        ;;
    -d | -delete )
        sed -i "$2"'d' "$today"
        exit 0
        ;;
    -p | -print )
        if [ "$2" = "number" ] || [ "$2" = "num" ] || [ "$2" = "n" ]; then
            cat -n "$today"
            exit 0
        fi
        cat "$today"
        exit 0
        ;;
    -h | * )
        usage
        ;;
esac
