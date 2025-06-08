#!/bin/bash

MINUTES_TO_SET=${1:-5}
SECONDS_TO_SET=$(( MINUTES_TO_SET * 60 ))
trap 'echo -e "\nChrono stopped. Bye!"; exit 0' INT
countdown() {
    local seconds=$1
    local paused=0
    while [ $seconds -gt 0 ]; do
        printf "\r %02d:%02d:%02d " $((seconds/3600)) $(( (seconds%3600)/60 )) $((seconds%60))
        read -t 1 -n 1 key
        if [[ "$key" == "p" ]]; then
            if [ "$paused" -eq 0 ]; then
                paused=1
                echo -e "\n⏸ Paused. Press p key again to resume..."
            else
                paused=0
                echo -e "\n▶ Resuming..."
            fi
        fi

       if [ $paused -eq 0 ]; then
            ((seconds--))
        fi
    done
    echo
}

while true; do
    countdown "$SECONDS_TO_SET"
done