# tools/preflight_validate_payload.ps1
$ErrorActionPreference = "Stop"
$payload = Join-Path (Get-Location) "payload\assets"
if (!(Test-Path $payload)) { Write-Error "payload\assets not found"; exit 1 }

# 1) Ensure MASTER SVGS exists and only 3 files
$masters = Join-Path $payload "MASTER SVGS"
if (!(Test-Path $masters)) { Write-Error "MASTER SVGS folder missing"; exit 1 }
$files = Get-ChildItem $masters -File | Select-Object -ExpandProperty Name
$allowed = @(
  "chronovolt_boot_master_redwhite_v1_1.svg",
  "covenant_master_template_for_main_app_screens_green&black.svg",
  "covenant_master_template_for_main_app_screens_blue.svg"
)
$bad = $files | Where-Object { $_ -notin $allowed }
if ($bad.Count -gt 0) {
  Write-Error "Unexpected files in MASTER SVGS: $($bad -join ', ')"; exit 1
}
if ($files.Count -ne 3) {
  Write-Error "MASTER SVGS must contain exactly 3 files; found $($files.Count)"; exit 1
}

# 2) Ensure sounds exist
$sfx = Join-Path $payload "SOUND_ASSETS\sfx"
$voices = Join-Path $payload "SOUND_ASSETS\voices"
if (!(Test-Path $sfx)) { Write-Error "SOUND_ASSETS\sfx missing"; exit 1 }
if (!(Test-Path $voices)) { Write-Error "SOUND_ASSETS\voices missing"; exit 1 }
if ((Get-ChildItem $sfx -File).Count -eq 0) { Write-Error "No SFX wav files found"; exit 1 }
if ((Get-ChildItem $voices -File).Count -eq 0) { Write-Error "No voice wav files found"; exit 1 }

Write-Host "[OK] Payload structure looks good."