#Setup OneDrive - setuponedrive.bat
FOR /F "DELIMS=" %%i IN (' WHOAMI /UPN ') DO @SET OSUSER=%%i
Echo %OSUSER%
SET OSREG="C:\Program Files\internet explorer\iexplore.exe" odopen://sync?useremail=%OSUSER%
%OSREG%
