#!/bin/bash

echo ' +-+-+-+-+-+-+ +-+-+ +-+-+-+-+
 |b|a|c|k|u|p| |m|e| |d|i|r|s|
 +-+-+-+-+-+-+ +-+-+ +-+-+-+-+';

BACKUP_DATE=$(date '+%Y-%m-%d_%H-%M-%S')
DIR_TO_BACKUP=$1
BACKUP_DESTINATION=$HOME/backup
BACKUP_NAME=$(basename "$DIR_TO_BACKUP")_"$BACKUP_DATE".tar.gz

if [ -z "$DIR_TO_BACKUP" ]; then
    echo
    echo "Usage: $0 </path/dir>"
    exit 1
fi

if [ ! -d "$DIR_TO_BACKUP" ]; then
    echo "$1 is not a directory"
    exit 1
fi

mkdir -p "$BACKUP_DESTINATION"
tar -czf "$BACKUP_DESTINATION/$BACKUP_NAME" -C "$(dirname "$DIR_TO_BACKUP")" "$(basename "$DIR_TO_BACKUP")"
echo
echo "Backup created:$BACKUP_DESTINATION/$BACKUP_NAME"
du -h "$BACKUP_DESTINATION/$BACKUP_NAME"
