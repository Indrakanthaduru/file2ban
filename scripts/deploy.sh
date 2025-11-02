#!/usr/bin/env bash
set -euo pipefail
# deploy.sh - install fail2ban (Debian/Ubuntu/Kali) and copy configs into /etc/fail2ban
# WARNING: This script modifies the system. Run only on test/lab VMs you control.

if [[ $EUID -ne 0 ]]; then
  echo "Please run as root or with sudo"
  exit 1
fi

echo "Installing fail2ban and iptables-persistent..."
apt-get update
apt-get install -y fail2ban iptables-persistent

echo "Copying config files..."
# backup existing
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
if [[ -d /etc/fail2ban ]]; then
  mkdir -p /etc/fail2ban-backup-$TIMESTAMP
  cp -r /etc/fail2ban/* /etc/fail2ban-backup-$TIMESTAMP/ || true
fi

cp -r configs/* /etc/fail2ban/
mkdir -p /etc/fail2ban/action.d
mkdir -p /etc/fail2ban/filter.d
cp configs/filters/*.conf /etc/fail2ban/filter.d/ || true
cp configs/actions/*.conf /etc/fail2ban/action.d/ || true

systemctl daemon-reload || true
systemctl restart fail2ban
systemctl enable fail2ban

echo "Fail2Ban deployed and started. Status:"
fail2ban-client status || true
