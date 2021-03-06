#!/usr/bin/env bash

# Include config
dir=$(pwd)
source "$dir"/conf.sh
source "$dir"/slack.sh

# Store sites with errors
ERRORS=""

for i in ${SITES[@]}
do
	cd "$ROOT/$i/public"
	# Verify checksums
	if ! /usr/local/bin/wp core verify-checksums; then
		ERRORS="$ERRORS $i"
	fi
done

if [ -n "$ERRORS" ]; then
	curl -u $TOKEN: https://api.pushbullet.com/v2/pushes -d type=note -d title="Server" -d body="Checksums verification failed for the following sites:$ERRORS"
fi