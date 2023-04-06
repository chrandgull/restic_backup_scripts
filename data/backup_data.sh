#!/bin/bash
set -uo pipefail

source /home/backupvm/src/data/env_data.bash

if [ -f "$MAINTENANCE_MARKER" ]; then
    echo "$MAINTENANCE_MARKER exists. Can't run backup during maintenance process."
else 
    touch $BACKUP_MARKER
    echo "$MAINTENANCE_MARKER does not exist."
    restic backup \
    --exclude-caches \
    --one-file-system \
    --quiet \
    --cleanup-cache \
    --exclude "$RESTIC_PATH/media" \
    --exclude "$RESTIC_PATH/torrents/downloads" \
    "$RESTIC_PATH"
    rm $BACKUP_MARKER
fi

source /home/backupvm/src/data/maint_data.sh

