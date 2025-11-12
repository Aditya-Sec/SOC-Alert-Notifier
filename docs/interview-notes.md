# Interview Notes – SOC Alert Notifier (Wazuh + Kibana + Slack)

## Slide 1 – Problem & Objective
- Traditional SOC analysts depend on dashboards and manual polling.
- Objective: build an **automated open-source alerting pipeline** to notify analysts in real time.
- Tools: **Wazuh (Detection) → Kibana (Visualization) → Slack (Notification)**.

## Slide 2 – Architecture & Implementation
- Logs collected with **Filebeat** → indexed in **Elasticsearch**.
- **Wazuh Manager** analyzes logs and applies **custom detection rules** (SSH brute-force, sudo escalation).
- Triggered alerts are forwarded to **Slack Webhook** using JSON payloads.
- Environment: Ubuntu 22.04 LTS on VMware Workstation Pro.

**Key commands shown during demo**
``bash
sudo tail -f /var/ossec/logs/alerts/alerts.json
sudo systemctl restart wazuh-manager
grep "sshd.*Failed" /var/log/auth.log

## Slide 3 – Results & Value

- Real-time Slack notifications within seconds of critical events.
- 100 % open-source; no license cost.
- Demonstrates automation, scripting, and SOC engineering capability.

## Future scope: integrate TheHive + MISP + AI-based Alert Prioritizer.

## One-liner summary for interviews

“I built an open-source SOC Alert Notifier that automatically pushes Wazuh detections from Kibana to Slack, enabling instant incident response without commercial SIEM tools.”
