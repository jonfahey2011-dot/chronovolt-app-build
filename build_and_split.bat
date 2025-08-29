@echo off
setlocal
if "%~1"=="" (
  echo Usage: build_and_split.bat ^<version^> [partSizeMB]
  echo Example: build_and_split.bat 1.0.0 5
  exit /b 1
)
set VERSION=%~1
set PART=%~2
if "%PART%"=="" set PART=5

set OUT=ChronoVolt_payload_v%VERSION%.zip
echo [MOTHER] Zipping payload with PowerShell Compress-Archive...
powershell -NoProfile -ExecutionPolicy Bypass -Command "if(Test-Path '%OUT%'){Remove-Item '%OUT%' -Force}; Compress-Archive -Path '.\payload\*' -DestinationPath '%OUT%' -Force"

if errorlevel 1 (
  echo [MOTHER] Zip failed.
  exit /b 2
)

echo [MOTHER] Splitting %OUT% into %PART% MB chunks...
powershell -NoProfile -ExecutionPolicy Bypass -File ".\tools\split_file.ps1" -Input "%OUT%" -PartMB %PART% -OutPrefix "ChronoVolt_v%VERSION%.zip"

echo [MOTHER] Generating checksums...
del checksums.sha256 2>nul
for %%F in (ChronoVolt_v%VERSION%.zip.*) do (
  certutil -hashfile "%%F" SHA256 >> checksums.sha256
)
certutil -hashfile "%OUT%" SHA256 >> checksums.sha256

echo [MOTHER] Writing parts list...
dir /b ChronoVolt_v%VERSION%.zip.* > parts_list.txt

echo [OK] Build complete. Parts, checksums.sha256 and %OUT% are ready.
endlocal