#!/usr/bin/env bash
# Run on Wazuh manager to list agents and show instructions
set -euo pipefail

echo "Listing Wazuh agents (manager):"
sudo /var/ossec/bin/list_agents || echo "list_agents not found; ensure Wazuh manager is installed."

echo
echo "To register an agent manually use manage_agents on manager:"
echo "sudo /var/ossec/bin/manage_agents"

#Make executable:

chmod +x scripts/register-agent.sh
