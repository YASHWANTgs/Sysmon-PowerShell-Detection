# Create output folder
$OutputFolder = "$PSScriptRoot\IR_Outputs"
If (!(Test-Path $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder | Out-Null
}

# Log file
$LogFile = "$OutputFolder\containment_log.txt"
"`n[START] Containment script started: $(Get-Date)" | Out-File $LogFile -Encoding utf8

# 1️⃣ Disable non-admin users (EXCLUDE 'Administrator', 'Admin', 'DefaultAccount', 'Guest')
"`n[INFO] Disabling non-admin local users..." | Out-File $LogFile -Append
$Users = Get-LocalUser | Where-Object {
    $_.Enabled -eq $true -and $_.Name -notmatch "Administrator|Admin|DefaultAccount|Guest"
}
foreach ($user in $Users) {
    try {
        Disable-LocalUser -Name $user.Name
        "[OK] Disabled user: $($user.Name)" | Out-File $LogFile -Append
    } catch {
        "[ERROR] Failed to disable user: $($user.Name) - $_" | Out-File $LogFile -Append
    }
}

# 2️⃣ Disable network adapter (to isolate host)
"`n[INFO] Disabling network adapters..." | Out-File $LogFile -Append
$Adapters = Get-NetAdapter | Where-Object {$_.Status -eq 'Up'}
foreach ($adapter in $Adapters) {
    try {
        Disable-NetAdapter -Name $adapter.Name -Confirm:$false
        "[OK] Disabled adapter: $($adapter.Name)" | Out-File $LogFile -Append
    } catch {
        "[ERROR] Failed to disable adapter: $($adapter.Name) - $_" | Out-File $LogFile -Append
    }
}

# 3️⃣ OPTIONAL: Kill suspicious processes
# Add specific names if you want (like 'mimikatz.exe', 'malware.exe')
# Example:
# "`n[INFO] Killing suspicious processes..." | Out-File $LogFile -Append
# $Suspicious = @("badprocess.exe", "mimikatz.exe")
# foreach ($procName in $Suspicious) {
#     Get-Process -Name $procName -ErrorAction SilentlyContinue | ForEach-Object {
#         try {
#             Stop-Process -Id $_.Id -Force
#             "[OK] Killed process: $($_.Name)" | Out-File $LogFile -Append
#         } catch {
#             "[ERROR] Could not kill: $($_.Name) - $_" | Out-File $LogFile -Append
#         }
#     }
# }

# ✅ Done
"`n[END] Containment actions completed: $(Get-Date)" | Out-File $LogFile -Append
Write-Host "`n✅ Containment actions completed. Log saved at: $LogFile" -ForegroundColor Green
