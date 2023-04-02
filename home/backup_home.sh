set -uo pipefail

source ~/src/home/env_home.bash

if [ -f "$MAINTENANCE_MARKER" ]; then
    echo "$MAINTENANCE_MARKER exists. Can't run backup during maintenance process."
else 
    touch $BACKUP_MARKER
    echo "$MAINTENANCE_MARKER does not exist."
    restic backup \
    --exclude-caches \
    --one-file-system \
    --verbose 1 \
    --cleanup-cache \
    --exclude "$RESTIC_PATH/Library" \
    "$RESTIC_PATH"
    rm $BACKUP_MARKER
fi


