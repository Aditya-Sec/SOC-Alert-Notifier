# Proof of Concept (POC): Open-Source SIEM Integration & SOC Setup

## 1. Objective
This POC demonstrates a compact, open-source SOC, delivering real-time threat detection and alerting using free tooling (Filebeat, Elasticsearch, Kibana, Wazuh, Slack).

## 2. Tools & Technologies
- Elasticsearch + Kibana
- Filebeat
- Wazuh Manager + Dashboard + Agents
- Slack (incoming webhook)
- Ubuntu 22.04 LTS (VMs)

## 3. Architecture & Data Flow
1. Server logs → Filebeat
2. Filebeat → Elasticsearch
3. Kibana visualizes `filebeat-*` and `wazuh-*` indices
4. Wazuh analyzes logs and triggers alerts
5. Alerts post to Slack via webhook (#alert)

(See `docs/architecture.png`)

## 4. Implementation steps (summary)
- Installed Elasticsearch & Kibana and verified via `http://192.168.206.133:9200` and Kibana UI.
- Configured Filebeat on endpoints to forward `/var/log/auth.log`.
- Installed Wazuh Manager and Dashboard; configured it to consume logs via Filebeat pipeline.
- Added local detection rules (`infra/wazuh/local_rules.xml`) for SSH brute-force and sudo escalation.
- Configured Slack integration in `ossec.conf` (use encrypted secret or .env in production).
- Tested by generating events (failed SSH attempts, sudo) and confirmed Slack notifications.

## 5. Use cases validated
- Brute-force SSH detection (multiple failed logins)
- Privilege escalation (successful sudo/root execution)
- Real-time Slack notifications sent to #alert

## 6. Benefits
- Cost-effective open-source SOC
- Real-time monitoring and alerting
- Customizable detection rules
- Centralized visibility via Kibana

## 7. Next steps and improvements
- Add automated playbooks (TheHive) to create cases in response to high-severity alerts.
- Add IOC enrichment (MISP / VirusTotal) before sending Slack alerts.
- Implement alert deduplication & suppression logic to reduce noise.
