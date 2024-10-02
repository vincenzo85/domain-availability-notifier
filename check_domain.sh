#!/bin/bash

# Domain to monitor
DOMAIN="********"

# Telegram bot token and chat ID
TOKEN="********"
CHAT_ID="********"
MESSAGE="The domain $DOMAIN is available for registration!"

# Check the domain status
STATUS=$(whois $DOMAIN | grep -i "Status:" | head -1)

# If the domain is available or no entries found, send a Telegram notification
if [[ $STATUS == *"AVAILABLE"* ]] || [[ $STATUS == *"no entries found"* ]]; then
  curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" -d chat_id=$CHAT_ID -d text="$MESSAGE"
  echo "Notification sent via Telegram: $MESSAGE"
else
  echo "The domain $DOMAIN is not available."
fi
