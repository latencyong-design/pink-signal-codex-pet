[CmdletBinding()]
param(
    [string]$CodexHome = ""
)

$ErrorActionPreference = "Stop"

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
if (Test-Path -LiteralPath $targetDir) {
    Remove-Item -LiteralPath $targetDir -Recurse -Force
    Write-Host "Removed Pink Signal from: $targetDir"
} else {
    Write-Host "Pink Signal is not installed at: $targetDir"
}
