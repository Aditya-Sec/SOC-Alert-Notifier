#!/usr/bin/env bash
# Find common secret patterns in repo (do NOT run blindly on remote)
set -euo pipefail

echo "Searching for Slack webhook patterns, AWS keys, private keys, and other secrets..."
echo

# Slack webhook pattern
grep -R --line-number "hooks.slack.com" || true

# Basic API key patterns
grep -R --line-number -E "API[_-]?KEY|api_key|SECRET|token|hooks.slack.com" || true

# Private key files
grep -R --line-number "BEGIN PRIVATE KEY" || true

echo
echo "If you find secrets, replace them with placeholders and rotate any real credentials."

#Make executable:

chmod +x scripts/sanitize-secrets.sh
