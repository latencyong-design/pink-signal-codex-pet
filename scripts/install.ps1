[CmdletBinding()]
param(
    [string]$CodexHome = ""
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$packageDir = Join-Path $repoRoot "package"
$petJson = Join-Path $packageDir "pet.json"
$spritesheet = Join-Path $packageDir "spritesheet.webp"

if (-not (Test-Path -LiteralPath $petJson)) {
    throw "pet.json not found: $petJson"
}

if (-not (Test-Path -LiteralPath $spritesheet)) {
    throw "spritesheet.webp not found: $spritesheet"
}

if ([string]::IsNullOrWhiteSpace($CodexHome)) {
    if (-not [string]::IsNullOrWhiteSpace($env:CODEX_HOME)) {
        $CodexHome = $env:CODEX_HOME
    } else {
        $home = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::UserProfile)
        if ([string]::IsNullOrWhiteSpace($home)) {
            throw "Could not resolve user home. Pass -CodexHome explicitly."
        }
        $CodexHome = Join-Path $home ".codex"
    }
}

$targetDir = Join-Path (Join-Path $CodexHome "pets") "pink-signal"
New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

Copy-Item -LiteralPath $petJson -Destination (Join-Path $targetDir "pet.json") -Force
Copy-Item -LiteralPath $spritesheet -Destination (Join-Path $targetDir "spritesheet.webp") -Force

Write-Host "Installed Pink Signal to: $targetDir"
Write-Host "Restart Codex if the pet list does not refresh immediately."
