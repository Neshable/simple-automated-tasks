#!/bin/bash

URL=$(cat /etc/monit/slack-url)

PAYLOAD="{
    \"attachments\": [
      {
        \"color\": \"#027953\",
        \"mrkdwn_in\": [\"text\"],
        \"text\" : \"Database backups complete. File: $UPLOADS_FILE , Database: $DATABASE_FILE No additional information is present at the moment.\",
        \"fields\": [
          { \"title\": \"Status\", \"value\": \"$DATABASE_STATUS\", \"short\": true },
          { \"title\": \"Website\", \"value\": \"$i\", \"short\": true }
        ]
      }
    ]
  }"