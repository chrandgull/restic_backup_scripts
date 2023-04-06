#!/bin/bash
set -uo

RESTIC_HOST="summit"
RESTIC_PATH="/mnt/remote/summit/data"
RESTIC_REPO_DESC="data"
RESTIC_PASSWORD="$(pass show "$RESTIC_HOST"/"$RESTIC_REPO_DESC"/RESTIC_PASSWORD)"
RESTIC_REPOSITORY="$(pass "$RESTIC_HOST"/"$RESTIC_REPO_DESC"/RESTIC_REPOSITORY)"
B2_ACCOUNT_ID="$(pass "$RESTIC_HOST"/"$RESTIC_REPO_DESC"/B2_ACCOUNT_ID)"
B2_ACCOUNT_KEY="$(pass "$RESTIC_HOST"/"$RESTIC_REPO_DESC"/B2_ACCOUNT_KEY)"
BACKUP_MARKER=/home/backupvm/data_directory_backup_in_progress
MAINTENANCE_MARKER=/home/backupvm/data_directory_maintenance_in_progress

export RESTIC_HOST RESTIC_PATH RESTIC_REPO_DESC RESTIC_REPOSITORY B2_ACCOUNT_ID B2_ACCOUNT_KEY RESTIC_PASSWORD