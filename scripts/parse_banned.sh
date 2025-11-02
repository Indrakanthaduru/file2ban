#!/usr/bin/env bash
# parse_banned.sh - query fail2ban-client and dump banned IPs to results/banned_ips.txt
set -euo pipefail
mkdir -p results
OUT=results/banned_ips.txt
: > "$OUT"

# get jails list
JAILS=$(fail2ban-client status 2>/dev/null | sed -n '2p' | sed 's/.*: //; s/,/ /g' || true)

if [[ -z "$JAILS" ]]; then
  echo "No jails found or fail2ban not running."
  exit 0
fi

for jail in $JAILS; do
  echo "Jail: $jail" >> "$OUT"
  fail2ban-client status "$jail" | sed -n '3p' >> "$OUT" || true
  echo "" >> "$OUT"
done

echo "Banned IPs exported to $OUT"
