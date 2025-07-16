@echo off
title Smart Board - {{APP_DISPLAY_NAME}}
color 0A

:: ================================================
:: SMART BOARD UNIVERSAL LAUNCHER TEMPLATE
:: Application: {{APP_DISPLAY_NAME}}
:: Category: {{APP_CATEGORY}}
:: Version: 1.0.0
:: ================================================

setlocal enabledelayedexpansion

:: Configuration des chemins
set "BASE_PATH=%USERPROFILE%\smart-board-app"
set "PYTHON_ENV=%BASE_PATH%\smartboard_env310"
set "APP_PATH=%BASE_PATH%\SMART_BOARD_Apps\{{APP_CATEGORY}}\{{APP_NAME}}"
set "LOGS_PATH=%BASE_PATH%\logs"
set "CONFIG_PATH=%BASE_PATH%\config"

:: Création des dossiers nécessaires
if not exist "%LOGS_PATH%" mkdir "%LOGS_PATH%"
if not exist "%APP_PATH%" mkdir "%APP_PATH%"

:: Affichage des informations
echo.
echo ================================================================
echo    SMART BOARD - {{APP_DISPLAY_NAME}}
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
if not exist "%APP_PATH%\{{MAIN_FILE}}" (
    echo [ERREUR] Fichier principal non trouvé !
    echo [INFO] Chemin attendu: %APP_PATH%\{{MAIN_FILE}}
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
echo [INFO] Démarrage de {{APP_DISPLAY_NAME}}...
echo [INFO] Appuyez sur Ctrl+C pour arrêter l'application
echo.
echo ================================================================
echo    APPLICATION EN COURS D'EXÉCUTION
echo ================================================================
echo.

:: Exécution avec gestion des erreurs
"%PYTHON_ENV%\Scripts\python.exe" "{{MAIN_FILE}}" 2>"%LOGS_PATH%\{{APP_NAME}}_error.log"

:: Gestion des codes de sortie
if %errorLevel% neq 0 (
    echo.
    echo [ERREUR] L'application s'est terminée avec une erreur (Code: %errorLevel%)
    echo [INFO] Vérifiez le fichier de log: %LOGS_PATH%\{{APP_NAME}}_error.log
    pause
    exit /b %errorLevel%
)

echo.
echo [INFO] Application terminée avec succès
echo [INFO] Appuyez sur une touche pour fermer...
pause >nul

endlocal
exit /b 0
