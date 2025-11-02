#!/usr/bin/env bash
# test_attack.sh - simulate SSH brute force attempts using sshpass (lab only)
# Usage: ./test_attack.sh TARGET_IP [USER] [COUNT] [PORT]
set -euo pipefail

TARGET=${1:-127.0.0.1}
USER=${2:-nonexistent}
COUNT=${3:-6}
PORT=${4:-22}

if ! command -v sshpass >/dev/null 2>&1; then
  echo "Install sshpass to run this test: sudo apt-get install -y sshpass"
  exit 1
fi

echo "[*] Simulating $COUNT failed SSH login attempts against $TARGET (user: $USER, port: $PORT)"
for i in $(seq 1 $COUNT); do
  sshpass -p wrongpassword ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 -p "$PORT" "$USER"@"$TARGET" exit || true
  sleep 1
done

echo "[*] Completed $COUNT failed attempts at $TARGET for user $USER"
