#!/bin/bash
set -e

ENV_FILE=".env.updater"

read -r -p "Enter RIPE_API_USER: " NEW_USER
read -r -s -p "Enter RIPE_API_PASS: " NEW_PASS
echo

BACKUP="${ENV_FILE}.bak.$(date +%Y%m%d_%H%M%S)"
cp "$ENV_FILE" "$BACKUP"
echo "Backup saved to $BACKUP"

sed -i -e '$a\' "$ENV_FILE"

if grep -q '^RIPE_API_USER=' "$ENV_FILE"; then
  sed -i "s/^RIPE_API_USER=.*/RIPE_API_USER=$NEW_USER/" "$ENV_FILE"
else
  echo "RIPE_API_USER=$NEW_USER" >> "$ENV_FILE"
fi

if grep -q '^RIPE_API_PASS=' "$ENV_FILE"; then
  sed -i "s/^RIPE_API_PASS=.*/RIPE_API_PASS=$NEW_PASS/" "$ENV_FILE"
else
  echo "RIPE_API_PASS=$NEW_PASS" >> "$ENV_FILE"
fi

docker compose down
docker compose up -d
