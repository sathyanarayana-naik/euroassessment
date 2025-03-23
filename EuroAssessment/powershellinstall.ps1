$psVersion = "7.3.0" # Change this to the desired version
$downloadUrl = "https://github.com/PowerShell/PowerShell/releases/download/v$psVersion/PowerShell-$psVersion-win-x64.msi"
$installerPath = "$env:TEMP\PowerShell-$psVersion-win-x64.msi"

function Download-Installer {
    try {
        Write-Host "Downloading PowerShell $psVersion installer..." -ForegroundColor Cyan
        Invoke-WebRequest -Uri $downloadUrl -OutFile $installerPath
        Write-Host "Download completed successfully." -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to download the installer: $_" -ForegroundColor Red
        exit 1
    }
}

function Install-PowerShell {
    try {
        Write-Host "Installing PowerShell $psVersion..." -ForegroundColor Cyan
        Start-Process msiexec.exe -ArgumentList "/i `"$installerPath`" /quiet /norestart" -Wait

        Write-Host "PowerShell $psVersion installed successfully." -ForegroundColor Green
    }
    catch {
        Write-Host "failed to install PowerShell: $_" -ForegroundColor Red
        exit 1
    }
}

function Verify-Installation {
    try {
        Write-Host "Verifying PowerShell $psVersion installation..." -ForegroundColor Cyan
        $psPath = "C:\Program Files\PowerShell\7\pwsh.exe"
        if (Test-Path $psPath) {
            Write-Host "powerShell $psVersion installation verified successfully." -ForegroundColor Green
        } else {
            Write-Host "Failed to verify the installation: pwsh.exe not found." -ForegroundColor Red
            exit 1
        }
    }
    catch {
        Write-Host "failed to verify the installation. $_" -ForegroundColor Red
        exit 1
    }
}

try {
    $psPath = "C:\Program Files\PowerShell\7\pwsh.exe"
    if (Test-Path $psPath) {
        $installedVersion = & $psPath --version
        if ($installedVersion -eq $psVersion) {
            Write-Host "PowerShell $psVersion is already installed." -ForegroundColor Green
            exit 0
        }
    }

    Download-Installer
    Install-PowerShell
    Verify-Installation
}
catch {
    Write-Host "error occurred: $_" -ForegroundColor Red
    exit 1
}
finally {
    if (Test-Path $installerPath) {
        Remove-Item $installerPath -Force
        Write-Host "installer cleaned up." -ForegroundColor Cyan
    }

    Write-Host "script execution completed." -ForegroundColor Cyan
}