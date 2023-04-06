#!/bin/bash

set -uo pipefail

source /home/backupvm/src/mainframe/env_mainframe.bash

if [ -f "$MAINTENANCE_MARKER" ]; then
    echo "$MAINTENANCE_MARKER exists. Can't run backup during maintenance process."
else 
    touch $BACKUP_MARKER
    echo "$MAINTENANCE_MARKER does not exist."
    restic backup \
    --exclude-caches \
    --cleanup-cache \
    --one-file-system \
    --no-scan \
    --exclude "$RESTIC_PATH/Library" \
    "$RESTIC_PATH"
    rm $BACKUP_MARKER
fi


source /home/backupvm/src/home/maint_mainframe.sh
