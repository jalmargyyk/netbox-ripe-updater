#!/bin/bash
set -e

ENV_FILE=".env.updater"

read -r -p "Enter RIPE_API_USER: " NEW_USER
read -r -s -p "Enter RIPE_API_PASS: " NEW_PASS
echo

BACKUP="${ENV_FILE}.bak.$(date +%Y%m%d_%H%M%S)"
cp "$ENV_FILE" "$BACKUP"
echo "Backup saved to $BACKUP"

sed -i "s/^RIPE_API_USER=.*/RIPE_API_USER=$NEW_USER/" "$ENV_FILE"
sed -i "s/^RIPE_API_PASS=.*/RIPE_API_PASS=$NEW_PASS/" "$ENV_FILE"

docker compose down
docker compose up -d
