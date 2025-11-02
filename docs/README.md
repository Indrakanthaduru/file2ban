# Fail2Ban Brute-Force Detection

This repository demonstrates a practical Fail2Ban deployment for detecting and mitigating brute-force attacks (SSH as an example). It contains configs, filters, actions, test scripts and sample logs.

## Quickstart
1. Copy config files to /etc/fail2ban (or run `scripts/deploy.sh` as root).
2. Restart fail2ban: `systemctl restart fail2ban`.
3. Run `scripts/test_attack.sh 127.0.0.1 attacker 6` from a separate host to simulate failed attempts.
4. Check `fail2ban-client status` and `journalctl -u fail2ban`.
5. Export banned IPs: `scripts/parse_banned.sh`.

## Security notes
- This repo is for lab/demo use. Do not run `test_attack.sh` against third-party systems.
- Adjust `bantime`, `maxretry`, and `findtime` to fit production risk tolerance.
