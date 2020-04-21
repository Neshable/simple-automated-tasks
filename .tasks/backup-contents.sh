#!/usr/bin/env bash

# Include config
dir=$(pwd)
source "$dir"/conf.sh
source "$dir"/slack.sh

# Filenames
NOW=$(date +%Y-%m-%d-%H%M%S)
UPLOADS_FILE="${NOW}-uploads.tar.gz";

for i in ${SITES[@]}
do
	cd "$i"
	# Backup uploads directory
	tar -zcf "../backups/$UPLOADS_FILE" wp-content/uploads
	# Remove old backups
	find ../backups -mtime +30 | xargs rm -fR
	# Send to mounted SMB
	cp "../backups/$UPLOADS_FILE" ${SMB_PATH}
    # Send notifications
    curl -s -X POST --data-urlencode "payload=$PAYLOAD" ${URL}
	# Send to S3
	#/usr/local/bin/aws s3 cp "../backups/$DATABASE_FILE.gz" "s3://$i/backups/" --storage-class REDUCED_REDUNDANCY
	#/usr/local/bin/aws s3 cp "../backups/$UPLOADS_FILE" "s3://$i/backups/" --storage-class REDUCED_REDUNDANCY
done
