@ECHO OFF

SET APP_ID=1829350

SET STEAM_CMD=C:\path\to\steamcmd\steamcmd.exe
SET FULL_INSTALL_PATH=%~dp0

%STEAM_CMD% ^
 +force_install_dir %FULL_INSTALL_PATH% ^
 +login anonymous ^
 +app_update %APP_ID% validate ^
 +quit

PAUSE
