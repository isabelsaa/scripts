#!/bin/bash

WORK_MINUTES=${1:-20}
BREAK_MINUTES=${2:-5}

WORK_SECONDS=$(( WORK_MINUTES * 60 ))
BREAK_SECONDS=$(( BREAK_MINUTES * 60 ))

trap 'echo -e "\nTake a break stopped. Bye!"; exit 0' INT
echo "======================================="
echo "     Take a break Configuration      "
echo "---------------------------------------"
echo " Work time:  $WORK_MINUTES minutes"
echo " Break time: $BREAK_MINUTES minutes"
echo "---------------------------------------"
echo " Press Ctrl+C  to exit"
echo "======================================="
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
    echo "Starting work period..."
    countdown "$WORK_SECONDS"
    notify-send "Break" "You need to take a break"
    read -n1 -rsp $'Press any key to start the break time...\n'
    echo "Break time! Relax..."
    countdown "$BREAK_SECONDS"
    notify-send "To work" "Now it is time to work"
    read -n1 -rsp $'Press any key to start the work time ...\n'
done