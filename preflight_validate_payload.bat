@echo off
setlocal
echo [MOTHER] Preflight: validating payload structure...
powershell -NoProfile -ExecutionPolicy Bypass -File ".\tools\preflight_validate_payload.ps1"
if errorlevel 1 (
  echo [MOTHER] Preflight FAILED. See messages above.
  exit /b 2
)
echo [OK] Preflight passed.
endlocal