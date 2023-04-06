#!/bin/bash

source /home/backupvm/src/data/env_data.bash

if test -f "$BACKUP_MARKER"; then
    echo "$BACKUP_MARKER exists. Cannot run maintenance process during backup process."
    exit 1 
fi

touch $MAINTENANCE_MARKER

restic forget \
    --host "$RESTIC_HOST" \
    --path "$RESTIC_PATH" \
    --tag '' \
    --keep-last 14 

restic prune

restic check --read-data-subset=1G 

rm $MAINTENANCE_MARKER
