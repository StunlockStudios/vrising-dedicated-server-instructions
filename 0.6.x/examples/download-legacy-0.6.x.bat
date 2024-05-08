@ECHO OFF

SET APP_ID=1829350
SET BETA_BRANCH=legacy-0.6.x

SET STEAM_CMD=C:\path\to\steamcmd\steamcmd.exe
SET FULL_INSTALL_PATH=%~dp0

%STEAM_CMD% ^
 +force_install_dir %FULL_INSTALL_PATH% ^
 +login anonymous ^
 +app_update %APP_ID% -beta %BETA_BRANCH% validate ^
 +quit

PAUSE
