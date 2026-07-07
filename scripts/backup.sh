#!/bin/bash

set -e

PROJECT_DIR="/home/ubuntu/aws-devops-assignment"
BUCKET_NAME="aws-devops-assignment-assets-alok-pandey-2026"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="aws-devops-backup-${TIMESTAMP}.tar.gz"

echo "Creating backup..."

tar -czf "/tmp/${BACKUP_FILE}" -C "$PROJECT_DIR" app nginx systemd README.md

echo "Uploading backup to S3..."

aws s3 cp "/tmp/${BACKUP_FILE}" "s3://${BUCKET_NAME}/backups/${BACKUP_FILE}"

echo "Cleaning up..."

rm "/tmp/${BACKUP_FILE}"

echo "Backup completed successfully."
