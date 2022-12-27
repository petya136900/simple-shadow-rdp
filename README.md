# simple-shadow-rdp
Simple bat script for RDP(Normal/Shadow) connections

<img src="https://user-images.githubusercontent.com/54180976/209712056-126d3f98-f482-4971-9fdf-aa6665878bcd.png" alt="qwinsta" width="500"/>
<img src="https://user-images.githubusercontent.com/54180976/209712169-9852705f-5eeb-4fe6-968a-741a61b97d99.png" alt="Connection type" width="300"/>

## Features

- Entering user credentials
- Displaying RDP sessions
- Shadow\Control\Normal connections

> For remote view & control RDP connection without user's prompt allow it in Group Policy

```batch
rem Allow shadow connections
reg ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
```
```batch
rem Allow control without user's permission
reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services" /v Shadow /t REG_DWORD /d 2 /f
```
