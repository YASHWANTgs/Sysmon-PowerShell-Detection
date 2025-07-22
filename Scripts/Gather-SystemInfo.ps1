# ========================================
# Incident Response Script: System Info Gathering
# Author: Yashwant G.S.
# ========================================

# Create a folder to store output (optional)
$outputFolder = "$PSScriptRoot\IR_Outputs"
if (!(Test-Path $outputFolder)) {
    New-Item -ItemType Directory -Path $outputFolder
}

# Gather basic system info
Get-ComputerInfo | Out-File "$outputFolder\system_info.txt"

# Get running processes
Get-Process | Sort-Object CPU -Descending | Out-File "$outputFolder\running_processes.txt"

# Get network connections
Get-NetTCPConnection | Out-File "$outputFolder\network_connections.txt"

# Get logged-on users (compatible method)
Get-WmiObject -Class Win32_LoggedOnUser | Out-File "$outputFolder\loggedon_users.txt"

# List scheduled tasks
Get-ScheduledTask | Out-File "$outputFolder\scheduled_tasks.txt"

# List startup programs
Get-CimInstance Win32_StartupCommand | Out-File "$outputFolder\startup_programs.txt"

# Capture installed software
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Select-Object DisplayName, DisplayVersion, Publisher, InstallDate |
    Out-File "$outputFolder\installed_apps.txt"

Write-Host "✅ System info gathered successfully in folder: $outputFolder"
