@echo off
title Dead Mall Arena - LAN server
cd /d "%~dp0"
echo Starting Dead Mall Arena...
where py >nul 2>nul
if %errorlevel%==0 (
  py -3 server.py --open %*
) else (
  python server.py --open %*
)
if errorlevel 1 (
  echo.
  echo Could not start. Python 3 is needed: https://www.python.org/downloads/
  echo When installing, tick "Add python.exe to PATH".
)
echo.
pause
