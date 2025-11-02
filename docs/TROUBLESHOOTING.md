# Troubleshooting

- **Fail2Ban not banning**: check `fail2ban-client status` and `journalctl -u fail2ban`. Confirm filter regex matches your distro's auth.log lines.
- **iptables rules not applied**: ensure the action script works on your distro and iptables is installed.
- **Using systemd journal**: if logs are managed by journald, ensure `backend = systemd` and your logpath entries are correct.
- **Test regex**: use fail2ban-regex to test your filter against sample logs:
  sudo fail2ban-regex results/sample-auth.log configs/filters/sshd-custom.conf
