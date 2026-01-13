# UDE: Universal Development Engine (Windows Module)
# Purpose: Automated provisioning of .NET 8 and AWS cloud tools

Write-Host "🚀 UDE: Initializing Windows Environment..." -ForegroundColor Cyan

# 1. Elevate to Admin if not already
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run this script as Administrator."
    exit
}

# 2. Verify WinGet
if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Error "WinGet is missing. Install 'App Installer' from the MS Store."
    exit
}

# 3. Define the Specialist Toolset
$apps = @(
    "Microsoft.DotNet.SDK.8", 
    "Amazon.AWSCLI", 
    "Git.Git",
    "Microsoft.VisualStudioCode",
    "Postman.Postman"
)

# 4. Automated Install
foreach ($app in $apps) {
    Write-Host "📦 Provisioning $app..." -ForegroundColor Yellow
    winget install --id $app --silent --accept-package-agreements --accept-source-agreements
}

Write-Host "✅ Environment Provisioned! Your terminal is ready for .NET & AWS development." -ForegroundColor Green
