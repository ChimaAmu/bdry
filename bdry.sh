#!/bin/bash
# Adds specified information into a time-formatted diary entry

usage() {
    echo "Usage: $(basename "$0") -a {data} to add to current day
       $(basename "$0") -d {line} to delete line
       $(basename "$0") -p to print current day entry
                  'n', 'num', or 'number' afterwards prints line numbers
       $(basename "$0") -e to edit entire current day entry file
                  start with line number to edit only the specified line
                  e.g. '1 hlelo hello'"
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
    -e | -edit ) 
        if [ "$#" -eq 4 ] ; then
            sed -i "$2"s/"$3"/"$4"/ "$today"
            sed -i "$2"s/$/" (edited at $(date +%T))"/ "$today"
            exit 0
        fi
        sed -i s/"$2"/"$3"/ "$today"
        echo "(edited file at $(date +%T))" >> "$today"
        exit 0
        ;;
    -h | * )
        usage
        ;;
esac
