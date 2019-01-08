#resetoffice.bat
#download OLicenseCleanup.vbs from:
#https://msdnshared.blob.core.windows.net/media/2018/05/OLicenseCleanup.vbs_.txt
ECHO OFF

ECHO Please wait while we reset your Office 365 suite. Please DO NOT close this window...


taskkill /f /fi "imagename eq lync.exe"
taskkill /f /fi "imagename eq outlook.exe"
reg delete "HKCU\Software\Microsoft\Office\16.0\Lync" /f
rmdir "%AppData%\Microsoft\Office\16.0\Lync\" /q /s
rmdir "%LocalAppData%\Microsoft\Office\16.0\Lync" /q /s

cscript c:\da\apps\OLicenseCleanup.vbs

REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /f

REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Shell /t REG_SZ /d "explorer.exe" /f

REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v Userinit /t REG_EXPAND_SZ /d "c:\windows\system32\userinit.exe," /f

net localgroup administrators "TM\Domain Users" /delete

manage-bde -protectors -enable C:

REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 1 /f

REG ADD "HKCU\Software\Microsoft\Internet Explorer\ProtocolExecute\odopen" /v WarnOnOpen /t REG_DWORD /d 0 /f

REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /v StartOneDrive /t REG_SZ /d "c:\da\apps\setuponedrive.bat"

CLS

ECHO Reset Complete - rebooting your computer automatically....
timeout 5

shutdown /r /t 5
