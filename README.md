# SOC Alert Notifier — Wazuh + Kibana + Slack
**Author:** Aditya Kumar Goswami

## Overview
This is my Proof of Concept (POC) for an open-source SOC Alert Notifier. It demonstrates an end-to-end log/alert pipeline where host logs are collected with Filebeat, analyzed by Wazuh, stored & visualized in Elasticsearch/Kibana, and critical alerts are forwarded to Slack via webhook for real-time operator notification.

**POC Objectives**
- Real-time threat detection and alerting using open-source tools.
- Generate alerts for use cases such as brute force and privilege escalation.
- Deliver cost-effective security visibility without commercial SIEM.

## Tools & Tech
- Elasticsearch + Kibana
- Filebeat
- Wazuh (Manager + Agents + Dashboard)
- Slack (Incoming Webhook)
- Ubuntu 22.04 LTS (VMs)
- VMware Workstation Pro (lab)

## Architecture
See `docs/architecture.png` for the architecture diagram.

Data flow:
`Server logs -> Filebeat -> Elasticsearch -> Kibana -> Wazuh rules -> Slack (webhook)`

## What I implemented
- Filebeat sends `/var/log/auth.log` (and other system logs) to Elasticsearch (`filebeat-*` index).
- Wazuh Manager analyzes the logs and generates alerts (wazuh-alerts-*, wazuh-monitoring-* indices).
- A custom Wazuh rule (local_rules.xml) detects SSH brute force and privilege escalation (sudo -> root).
- Wazuh is configured to forward alerts to Slack using the incoming webhook format.
- Kibana dashboards show `filebeat-*` and `wazuh-*` indices for discovery and monitoring.

## How to reproduce (high level)
1. Provision Ubuntu 22.04 for central server (Elasticsearch, Kibana, Wazuh Manager).
2. Install and configure Elasticsearch and Kibana.
3. Install Filebeat on the monitored host(s) and point `filebeat.yml` to `192.168.206.133:9200`.
4. Install Wazuh Manager and Dashboard and configure Filebeat → Wazuh pipeline.
5. Add the `infra/wazuh/local_rules.xml` rule and restart Wazuh manager.
6. Configure Slack incoming webhook (use `.env` for secrets) and add the webhook to `infra/wazuh/ossec.conf.example` (replace placeholder).
7. Trigger events (failed SSH, sudo) and verify Slack messages appear in `#alert`.

## Files of interest
- `infra/filebeat.yml` — Filebeat config to collect Suricata or system logs.
- `infra/wazuh/local_rules.xml` — Custom local detection rules used in POC.
- `infra/wazuh/ossec.conf.example` — Example Wazuh manager config with Slack integration (webhook placeholder).
- `scripts/add-local-rule.sh` — Helper to install the local rules and restart Wazuh.
- `snapshots/*` — CLI/Kibana/Wazuh sample outputs used as proof.

## Evidence and snapshots
See the `snapshots/` folder for realistic outputs and a Slack alert screenshot (`snapshot-slack-alert.txt` contains the exact message payload).

## Security notes
- **Do not commit real API keys or webhooks**. Use `.env` and add `.env` to `.gitignore`.
- If a real webhook was accidentally committed, rotate it immediately and remove it from git history.

## Contact
Aditya Kumar Goswami
