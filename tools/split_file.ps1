# tools/split_file.ps1
param(
  [Parameter(Mandatory=$true)][string]$Input,
  [int]$PartMB = 5,
  [string]$OutPrefix = "part"
)

$ErrorActionPreference = "Stop"
if (!(Test-Path $Input)) { Write-Error "Input not found: $Input"; exit 1 }
$bytesPerPart = $PartMB * 1MB
$fs = [System.IO.File]::OpenRead($Input)
$buffer = New-Object byte[] $bytesPerPart
$index = 1
while ($true) {
  $read = $fs.Read($buffer, 0, $buffer.Length)
  if ($read -le 0) { break }
  $out = "{0}.{1:D3}" -f $OutPrefix, $index
  $tmp = if ($read -eq $buffer.Length) { $buffer } else { $buffer[0..($read-1)] }
  [System.IO.File]::WriteAllBytes($out, $tmp)
  Write-Host "Wrote $out ($read bytes)"
  $index++
}
$fs.Close()