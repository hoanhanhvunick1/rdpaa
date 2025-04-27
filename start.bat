@echo off
echo Starting setup script (downloaded version)...
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" > out.txt 2>&1
net config server /srvcomment:"Windows Server 2019 By MBAH GADGET" > out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F > out.txt 2>&1
REM REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f /v Wallpaper /t REG_SZ /d .\wallpaper.bat
echo Setting up user account...
net user administrator JohnTech1234 /add >nul
net localgroup administrators administrator /add >nul
net user administrator /active:yes >nul
net user installer /delete >nul 2>&1
echo Configuring system...
diskperf -Y >nul
sc config Audiosrv start= auto >nul
sc start Audiosrv >nul
ICACLS C:\Windows\Temp /grant administrator:F >nul
ICACLS C:\Windows\installer /grant administrator:F >nul
echo Basic setup complete.
echo Checking Ngrok status...
tasklist | find /i "ngrok.exe" >Nul && echo Ngrok is Running - Check Dashboard for IP/Port: https://dashboard.ngrok.com/endpoints/status || echo WARNING: Ngrok process not found or tunnel failed! Check Action logs.
echo.
echo RDP Login Information:
echo Username: administrator
echo Password: JohnTech1234
echo.
echo You should be able to connect via RDP if Ngrok tunnel is active.
