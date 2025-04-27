@echo off
echo Setting up Windows environment...

REM --- Windows Configuration ---
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" > out.txt 2>&1
net config server /srvcomment:"Windows Server 2019 Prepared for RDP" > out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F > out.txt 2>&1
REM Ensure wallpaper.bat exists if you use this line
REM REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f /v Wallpaper /t REG_SZ /d D:\a\wallpaper.bat

REM --- User Account Setup ---
echo Configuring administrator account...
net user administrator JohnTech1234 /add > nul 2>&1
net localgroup administrators administrator /add > nul 2>&1
net user administrator /active:yes > nul 2>&1
REM Attempt to delete default user 'installer' if it exists
net user installer /delete > nul 2>&1

REM --- System Performance and Services ---
diskperf -Y > nul
sc config Audiosrv start= auto > nul
sc start Audiosrv > nul

REM --- Permissions ---
ICACLS C:\Windows\Temp /grant administrator:F > nul
ICACLS C:\Windows\installer /grant administrator:F > nul

echo Setup script completed basic configurations successfully.

REM --- Ngrok Status Check (No IP retrieval) ---
echo Checking Ngrok status...
tasklist | find /i "ngrok.exe" >Nul
if %errorlevel%==0 (
    echo Ngrok process is running.
    echo !!! IMPORTANT: Please check your Ngrok Dashboard (https://dashboard.ngrok.com/endpoints/status) !!!
    echo !!!            to get the RDP Address (e.g., 0.tcp.ngrok.io) and Port. !!!
) else (
    echo WARNING: Ngrok process was not found running. Tunnel may not be active.
)

REM --- Login Information ---
echo.
echo RDP Login Information:
echo Username: administrator
echo Password: JohnTech1234
echo.
echo You should be able to login via RDP soon if Ngrok tunnel is active.
echo The GitHub Action will be kept alive by loop.ps1 (if used).

REM --- End of Script ---
REM Removed the 'ping -n 10 127.0.0.1' command as it's not effective for keep-alive.
