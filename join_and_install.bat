@echo off
setlocal
set ZIPNAME=ChronoVolt_joined.zip
set TARGET=C:\ChronoVolt

echo [MOTHER] Joining parts into %ZIPNAME%...
copy /b ChronoVolt_v*.zip.0* "%ZIPNAME%" >nul

if exist checksums.sha256 (
  echo [MOTHER] Verifying checksums...
  for %%F in (ChronoVolt_v*.zip.0*) do certutil -hashfile "%%F" SHA256
  certutil -hashfile "%ZIPNAME%" SHA256
)

echo [MOTHER] Extracting to %TARGET% ...
powershell -NoProfile -ExecutionPolicy Bypass -Command "if(Test-Path '%TARGET%'){Remove-Item -Recurse -Force '%TARGET%'}; New-Item -ItemType Directory -Path '%TARGET%' | Out-Null; Expand-Archive -Path '%ZIPNAME%' -DestinationPath '%TARGET%' -Force"

echo [OK] Installed to %TARGET%.
pause
endlocal