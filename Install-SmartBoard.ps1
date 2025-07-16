# ================================================
# SMART BOARD - INSTALLATION AUTOMATIQUE
# Script d'installation et configuration
# Version: 1.0.0
# ================================================

param(
    [string]$InstallPath = "$env:USERPROFILE\smart-board-app",
    [switch]$Force
)

function Write-ColoredOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

function Test-AdminPrivileges {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Install-SmartBoard {
    Write-ColoredOutput "================================================" "Cyan"
    Write-ColoredOutput "    SMART BOARD - INSTALLATION AUTOMATIQUE" "Cyan"
    Write-ColoredOutput "================================================" "Cyan"
    Write-ColoredOutput ""
    
    # Vérification des privilèges administrateur
    if (-not (Test-AdminPrivileges)) {
        Write-ColoredOutput "⚠️  Privilèges administrateur requis !" "Red"
        Write-ColoredOutput "Veuillez relancer ce script en tant qu'administrateur." "Yellow"
        exit 1
    }
    
    Write-ColoredOutput "✓ Privilèges administrateur confirmés" "Green"
    
    # Création du répertoire d'installation
    Write-ColoredOutput "📁 Création du répertoire d'installation..." "White"
    $SmartBoardPath = Join-Path $InstallPath "SMART_BOARD_Apps"
    
    if ((Test-Path $SmartBoardPath) -and -not $Force) {
        Write-ColoredOutput "⚠️  Le répertoire existe déjà: $SmartBoardPath" "Yellow"
        Write-ColoredOutput "Utilisez -Force pour forcer l'installation" "Yellow"
        exit 1
    }
    
    if (Test-Path $SmartBoardPath) {
        Remove-Item $SmartBoardPath -Recurse -Force
    }
    
    New-Item -ItemType Directory -Path $SmartBoardPath -Force | Out-Null
    Write-ColoredOutput "✓ Répertoire créé: $SmartBoardPath" "Green"
    
    # Copie des fichiers d'application
    Write-ColoredOutput "📦 Copie des applications..." "White"
    
    $Categories = @("body_tracking", "gestures", "Réalité virtuelle", "resources", "voice_assistant", "whiteboards")
    
    foreach ($Category in $Categories) {
        if (Test-Path $Category) {
            $DestPath = Join-Path $SmartBoardPath $Category
            Copy-Item $Category $DestPath -Recurse -Force
            Write-ColoredOutput "  ✓ Copié: $Category" "Green"
        }
    }
    
    # Copie des fichiers de configuration
    Write-ColoredOutput "⚙️  Installation des configurations..." "White"
    
    if (Test-Path "config") {
        $ConfigPath = Join-Path $InstallPath "config"
        Copy-Item "config" $ConfigPath -Recurse -Force
        Write-ColoredOutput "  ✓ Configurations copiées" "Green"
    }
    
    # Création des scripts de lancement globaux
    Write-ColoredOutput "🚀 Création des scripts de lancement..." "White"
    
    $LaunchScriptsPath = Join-Path $InstallPath "launch_scripts"
    New-Item -ItemType Directory -Path $LaunchScriptsPath -Force | Out-Null
    
    # Copie du template et du manager
    if (Test-Path "templates") {
        Copy-Item "templates" (Join-Path $InstallPath "templates") -Recurse -Force
    }
    
    if (Test-Path "SmartBoard-Manager.ps1") {
        Copy-Item "SmartBoard-Manager.ps1" $InstallPath -Force
    }
    
    Write-ColoredOutput "✓ Scripts de lancement créés" "Green"
    
    # Création du script de mise à jour
    $UpdateScriptPath = Join-Path $InstallPath "Update-SmartBoard.ps1"
    $UpdateScriptContent = @"
# Script de mise à jour Smart Board
param([string]`$Source = "https://github.com/web-app-ia/SMART-BOARD-CONTENU.git")

Write-Host "Mise à jour Smart Board..." -ForegroundColor Cyan
Write-Host "Source: `$Source" -ForegroundColor Yellow

# Ici vous pouvez ajouter la logique de mise à jour
# Par exemple, cloner le repository et copier les nouveaux fichiers

Write-Host "Mise à jour terminée !" -ForegroundColor Green
"@
    
    Set-Content -Path $UpdateScriptPath -Value $UpdateScriptContent -Encoding UTF8
    Write-ColoredOutput "✓ Script de mise à jour créé" "Green"
    
    # Finalisation
    Write-ColoredOutput "" "White"
    Write-ColoredOutput "================================================" "Cyan"
    Write-ColoredOutput "    INSTALLATION TERMINÉE AVEC SUCCÈS !" "Cyan"
    Write-ColoredOutput "================================================" "Cyan"
    Write-ColoredOutput "" "White"
    Write-ColoredOutput "📍 Répertoire d'installation: $InstallPath" "White"
    Write-ColoredOutput "📁 Applications: $SmartBoardPath" "White"
    Write-ColoredOutput "⚙️  Configuration: $(Join-Path $InstallPath "config")" "White"
    Write-ColoredOutput "" "White"
    Write-ColoredOutput "🎯 Prochaines étapes:" "Yellow"
    Write-ColoredOutput "  1. Lancez Smart Board App depuis le répertoire principal" "White"
    Write-ColoredOutput "  2. Testez les différentes applications" "White"
    Write-ColoredOutput "  3. Consultez la documentation sur GitHub" "White"
    Write-ColoredOutput "" "White"
}

# Exécution
Install-SmartBoard
