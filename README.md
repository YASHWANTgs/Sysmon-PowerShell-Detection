# Detectiong Obfuscated PowerShell Activiry uding Sysmon

The main goal of this project is to identifying suspicious powershell activity on a windows system suing **Sysmon**.This has been done by manually excecuting base64-encoded PowerShell command. This simulates a specific attack behavior **Event ID 4104** - which logs script block execution.

 ---

 # Project Overview 

 Attackers commonly used these type of PowerShell to execute fileless malware or perform reconnaissance. These commands are base64-encoded to evade basic detection and uses sysmon by which we cature and analyse such activity through windows event logs.

 This lab demonstrated how a SOC analyst or defender can:
- Capture malicious script execuriton, Use Event Viewer to find key indicators, Map the behavior to MITRE ATT&CK

---

# Tools Used 
- Sysmon64.exe (Microfost SYsinternals)
- Windows Powershell (for simulating attack)
- Event Viewer (for observing logs)

---

# Steps Performed

First installed Sysmon with a config that logs Powershell Scri[pt blocks, Ran a base64-encoded Powershell command mimicking an attacker,Observed Event ID 4104 in Event Viewer under :Applications and Services Logs > Microsoft > Windows > PowerShell > Operational`, Collected the screenshots.

#MITRE ATT&CK Mapping 
Execution-PowerShell-T1059.001
Defensive Evasion-Obfucatted Commands-T1027

# Outcome 
This Project demonstrates real-worlddetection caability for obfuscated script execution.

