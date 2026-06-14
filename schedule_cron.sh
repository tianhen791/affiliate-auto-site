#!/usr/bin/env bash
# Add cron job once
CRONENTRY="$(cat config.yaml | grep update_interval | awk -F'"' '{print $2}') $(realpath build_site.sh)"
if crontab -l 2>/dev/null | grep -F "$CRONENTRY" >/dev/null; then
    echo "Cron already set"
else
    (crontab -l 2>/dev/null; echo "${CRONENTRY}") | crontab -
    echo "Cron added: $CRONENTRY"
fi
