@echo off
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" > out.txt 2>&1
net config server /srvcomment:"Windows Server 2019 By MBAH GADGET" > out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F > out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /f /v Wallpaper /t REG_SZ /d D:\a\wallpaper.bat
net user administrator JohnTech1234 /add >nul
net localgroup administrators administrator /add >nul
net user administrator /active:yes >nul
net user installer /delete
diskperf -Y >nul
sc config Audiosrv start= auto >nul
sc start audiosrv >nul
ICACLS C:\Windows\Temp /grant administrator:F >nul
ICACLS C:\Windows\installer /grant administrator:F >nul
echo Success!
echo IP:
REM --- PHẦN ĐƯỢC SỬA ĐỔI ---
REM Kiểm tra xem ngrok có chạy không, nếu có thì yêu cầu kiểm tra dashboard, nếu không thì báo lỗi.
tasklist | find /i "ngrok.exe" >Nul && echo Ngrok is Running - Check Dashboard for IP/Port: https://dashboard.ngrok.com/endpoints/status || echo WARNING: Ngrok process not found or tunnel failed! Check logs.
REM --- KẾT THÚC PHẦN SỬA ĐỔI ---
echo Username: administrator
echo Password: JohnTech1234
echo You can login now.
ping -n 10 127.0.0.1 >nul
