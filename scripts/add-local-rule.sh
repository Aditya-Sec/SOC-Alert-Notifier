#!/usr/bin/env bash
# Usage: sudo ./scripts/add-local-rule.sh
set -euo pipefail

RULE_SRC="infra/wazuh/local_rules.xml"
RULE_DST="/var/ossec/etc/rules/local_rules.xml"

if [ ! -f "$RULE_SRC" ]; then
  echo "Local rule file not found: $RULE_SRC"
  exit 1
fi

echo "Copying $RULE_SRC -> $RULE_DST"
sudo cp "$RULE_SRC" "$RULE_DST"
sudo chown root:ossec "$RULE_DST"
sudo chmod 640 "$RULE_DST"

echo "Restarting Wazuh manager (systemd)"
sudo systemctl restart wazuh-manager
echo "Wazuh manager restarted. Check logs: sudo journalctl -u wazuh-manager -f"

#Make executable

chmod +x scripts/add-local-rule.sh
