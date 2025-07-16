@echo off
title Smart Board - Objets Virtuels
color 0A

:: ================================================
:: SMART BOARD UNIVERSAL LAUNCHER TEMPLATE
:: Application: Objets Virtuels
:: Category: ar_vr
:: Version: 1.0.0
:: ================================================

setlocal enabledelayedexpansion

:: Configuration des chemins
set "BASE_PATH=%USERPROFILE%\smart-board-app"
set "PYTHON_ENV=%BASE_PATH%\smartboard_env310"
set "APP_PATH=%BASE_PATH%\SMART_BOARD_Apps\ar_vr\virtual_objects"
set "LOGS_PATH=%BASE_PATH%\logs"
set "CONFIG_PATH=%BASE_PATH%\config"

:: Création des dossiers nécessaires
if not exist "%LOGS_PATH%" mkdir "%LOGS_PATH%"
if not exist "%APP_PATH%" mkdir "%APP_PATH%"

:: Affichage des informations
echo.
echo ================================================================
echo    SMART BOARD - Objets Virtuels
echo ================================================================
echo.
echo [INFO] Initialisation de l'application...
echo [INFO] Chemin: %APP_PATH%
echo [INFO] Environnement Python: %PYTHON_ENV%
echo.

:: Vérification des privilèges administrateur
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERREUR] Privilèges administrateur requis !
    echo [INFO] Relancez ce script en tant qu'administrateur
    pause
    exit /b 1
)

:: Vérification de l'environnement Python
if not exist "%PYTHON_ENV%\Scripts\python.exe" (
    echo [ERREUR] Environnement Python non trouvé !
    echo [INFO] Chemin attendu: %PYTHON_ENV%\Scripts\python.exe
    echo [INFO] Veuillez installer l'environnement Python d'abord
    pause
    exit /b 1
)

:: Vérification du fichier principal
if not exist "%APP_PATH%\app.py" (
    echo [ERREUR] Fichier principal non trouvé !
    echo [INFO] Chemin attendu: %APP_PATH%\app.py
    echo [INFO] Veuillez télécharger/installer l'application
    pause
    exit /b 1
)

:: Activation de l'environnement Python
echo [INFO] Activation de l'environnement Python...
call "%PYTHON_ENV%\Scripts\activate.bat"

:: Vérification et installation des dépendances
if exist "%APP_PATH%\requirements.txt" (
    echo [INFO] Vérification des dépendances...
    pip install -r "%APP_PATH%\requirements.txt" --quiet
)

:: Changement vers le répertoire de l'application
cd /d "%APP_PATH%"

:: Démarrage de l'application
echo [INFO] Démarrage de Objets Virtuels...
echo [INFO] Appuyez sur Ctrl+C pour arrêter l'application
echo.
echo ================================================================
echo    APPLICATION EN COURS D'EXÉCUTION
echo ================================================================
echo.

:: Exécution avec gestion des erreurs
"%PYTHON_ENV%\Scripts\python.exe" "app.py" 2>"%LOGS_PATH%\virtual_objects_error.log"

:: Gestion des codes de sortie
if %errorLevel% neq 0 (
    echo.
    echo [ERREUR] L'application s'est terminée avec une erreur (Code: %errorLevel%)
    echo [INFO] Vérifiez le fichier de log: %LOGS_PATH%\virtual_objects_error.log
    pause
    exit /b %errorLevel%
)

echo.
echo [INFO] Application terminée avec succès
echo [INFO] Appuyez sur une touche pour fermer...
pause >nul

endlocal
exit /b 0

