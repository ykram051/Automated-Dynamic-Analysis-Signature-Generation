@echo off
setlocal

REM One-click launcher for Windows users.
REM Runs PowerShell startup script from this repository root.

set SCRIPT_DIR=%~dp0
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%start.ps1"
if errorlevel 1 (
  echo.
  echo Startup failed. Check errors above.
  exit /b 1
)

endlocal
