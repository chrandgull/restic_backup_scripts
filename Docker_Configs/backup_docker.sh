#!/bin/bash

set -uo pipefail

source /home/backupvm/src/Docker_Configs/env_docker.bash

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
    --exclude "$RESTIC_PATH/arch-delugevpn/data/" \
    "$RESTIC_PATH"
    rm $BACKUP_MARKER
fi


source /home/backupvm/src/Docker_Configs/maint_docker.sh
