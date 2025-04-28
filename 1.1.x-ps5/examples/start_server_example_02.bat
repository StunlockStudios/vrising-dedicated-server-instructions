@echo off

set SteamAppId=1604030

REM Get date/time in a consistent format no matter what locale.
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "MIN=%dt:~10,2%" & set "SEC=%dt:~12,2%"
set "TIMESTAMP=%YYYY%%MM%%DD%_%HH%%MIN%%SEC%"

SET SV_ID=1001
SET BASE_PORT=27100

REM Ports based off of BASE_PORT.
SET /a "GAME_PORT=%BASE_PORT%+15"
SET /a "QUERY_PORT=%BASE_PORT%+16"
SET /a "API_PORT=%BASE_PORT%+17"
SET /a "RCON_PORT=%BASE_PORT%+18"

echo "Starting V Rising Dedicated Server - PRESS CTRL-C to exit"

@echo on
VRisingServer.exe ^
 -persistentDataPath ..\..\save-data\%SV_ID% ^
 -serverName "My V Rising Server #%SV_ID%" ^
 -description "Welcome to the server" ^
 -saveName "world27" ^
 -gamePort %GAME_PORT% ^
 -queryPort %QUERY_PORT% ^
 -apiPort %API_PORT% ^
 -rconPort %RCON_PORT% ^
 -rconEnabled true ^
 -rconPassword "VerySecretPassword" ^
 -rconExperimentalEnabled true ^
 -apiEnabled true ^
 -bindAddress 10.27.1.56 ^
 -rconBindAddress 10.27.1.56 ^
 -maxUsers 60 ^
 -maxAdmins 2 ^
 -fps 30 ^
 -preset StandardPvE ^
 -difficultyPreset Difficulty_Brutal ^
 -listOnEOS true ^
 -saveCount 30 ^
 -saveInterval 60 ^
 -adminOnlyDebugEvents true ^
 -debugEvents true ^
 -resetDaysInterval 30 ^
 -dayOfReset Saturday ^
 -logFile "..\..\logs\VRisingServer-%SV_ID%-%TIMESTAMP%.log" 1> nul
