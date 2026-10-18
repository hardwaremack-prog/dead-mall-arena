@echo off
title Join a Dead Mall Arena game
set /p HOSTIP=Enter the address shown in the host's server window (like 192.168.1.20:8090):
if "%HOSTIP%"=="" exit /b
echo %HOSTIP% | find ":" >nul
if %errorlevel%==0 (start "" "http://%HOSTIP%/") else (start "" "http://%HOSTIP%:8090/")
