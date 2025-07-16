# ================================================
# SMART BOARD MANAGER
# Script de gestion et génération des lanceurs
# Version: 1.0.0
# ================================================

param(
    [string]$Action = "generate",
    [string]$ConfigPath = "config\deployment_config.json"
)

# Configuration des applications
$Applications = @{
    "body_tracking" = @{
        "display_name" = "Suivi Corporel"
        "apps" = @{
            "pose_detection" = @{
                "display_name" = "Détection de Poses"
                "main_file" = "main.py"
                "launch_script" = "launch_pose_detection_admin.bat"
            }
            "gesture_control" = @{
                "display_name" = "Contrôle Gestuel"
                "main_file" = "main.py"
                "launch_script" = "launch_gesture_control_admin.bat"
            }
        }
    }
    "gestures" = @{
        "display_name" = "Gestuelle des Mains"
        "apps" = @{
            "hand_tracking" = @{
                "display_name" = "Suivi des Mains"
                "main_file" = "main.py"
                "launch_script" = "launch_hand_tracking_admin.bat"
            }
            "finger_counter" = @{
                "display_name" = "Compteur de Doigts"
                "main_file" = "main.py"
                "launch_script" = "launch_finger_counter_admin.bat"
            }
        }
    }
    "ar_vr" = @{
        "display_name" = "Réalité Augmentée/Virtuelle"
        "folder_name" = "Réalité virtuelle"
        "apps" = @{
            "ar_overlay" = @{
                "display_name" = "Overlay AR"
                "main_file" = "main.py"
                "launch_script" = "launch_ar_overlay_admin.bat"
            }
            "virtual_objects" = @{
                "display_name" = "Objets Virtuels"
                "main_file" = "app.py"
                "launch_script" = "launch_virtual_objects_admin.bat"
            }
        }
    }
    "resources" = @{
        "display_name" = "Ressources Pédagogiques"
        "apps" = @{
            "math_tools" = @{
                "display_name" = "Outils Mathématiques"
                "main_file" = "main.py"
                "launch_script" = "launch_math_tools_admin.bat"
            }
            "science_sim" = @{
                "display_name" = "Simulateur Scientifique"
                "main_file" = "main.py"
                "launch_script" = "launch_science_sim_admin.bat"
            }
        }
    }
    "voice_assistant" = @{
        "display_name" = "Assistant Vocal"
        "apps" = @{
            "speech_recognition" = @{
                "display_name" = "Reconnaissance Vocale"
                "main_file" = "main.py"
                "launch_script" = "launch_speech_recognition_admin.bat"
            }
            "voice_commands" = @{
                "display_name" = "Commandes Vocales"
                "main_file" = "main.py"
                "launch_script" = "launch_voice_commands_admin.bat"
            }
        }
    }
    "whiteboards" = @{
        "display_name" = "Tableaux Virtuels"
        "apps" = @{
            "drawing_board" = @{
                "display_name" = "Tableau de Dessin"
                "main_file" = "main.py"
                "launch_script" = "launch_drawing_board_admin.bat"
            }
            "collaborative_board" = @{
                "display_name" = "Tableau Collaboratif"
                "main_file" = "main.py"
                "launch_script" = "launch_collaborative_board_admin.bat"
            }
        }
    }
}

function Write-ColoredOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

function Generate-ApplicationFiles {
    param(
        [string]$Category,
        [string]$AppName,
        [hashtable]$AppConfig
    )
    
    $FolderName = if ($Applications[$Category]["folder_name"]) { $Applications[$Category]["folder_name"] } else { $Category }
    $AppPath = Join-Path $FolderName $AppName
    
    Write-ColoredOutput "  → Génération des fichiers pour $($AppConfig.display_name)..." "Yellow"
    
    # Créer le répertoire s'il n'existe pas
    if (-not (Test-Path $AppPath)) {
        New-Item -ItemType Directory -Path $AppPath -Force | Out-Null
    }
    
    # Générer le script .bat de lancement
    $TemplatePath = "templates\universal_launcher_template.bat"
    if (Test-Path $TemplatePath) {
        $TemplateContent = Get-Content $TemplatePath -Raw
        
        # Remplacer les placeholders
        $BatContent = $TemplateContent -replace '{{APP_DISPLAY_NAME}}', $AppConfig.display_name
        $BatContent = $BatContent -replace '{{APP_CATEGORY}}', $Category
        $BatContent = $BatContent -replace '{{APP_NAME}}', $AppName
        $BatContent = $BatContent -replace '{{MAIN_FILE}}', $AppConfig.main_file
        
        # Sauvegarder le script .bat
        $BatPath = Join-Path $AppPath $AppConfig.launch_script
        Set-Content -Path $BatPath -Value $BatContent -Encoding UTF8
        Write-ColoredOutput "    ✓ Script généré: $BatPath" "Green"
    }
    
    # Générer le fichier principal Python (si inexistant)
    $MainFilePath = Join-Path $AppPath $AppConfig.main_file
    if (-not (Test-Path $MainFilePath)) {
        $PythonContent = @"
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
Smart Board Application: $($AppConfig.display_name)
Category: $($Applications[$Category].display_name)
Generated automatically by SmartBoard-Manager.ps1
'''

import cv2
import numpy as np
import sys
import os

def main():
    '''
    Application principale pour $($AppConfig.display_name)
    '''
    print("=" * 60)
    print(f"    SMART BOARD - $($AppConfig.display_name)")
    print("=" * 60)
    print()
    print("Application initialisée avec succès !")
    print("Appuyez sur 'q' pour quitter")
    print()
    
    # Initialisation de la caméra
    cap = cv2.VideoCapture(0)
    
    if not cap.isOpened():
        print("Erreur: Impossible d'ouvrir la caméra")
        return
    
    while True:
        ret, frame = cap.read()
        if not ret:
            print("Erreur: Impossible de lire le flux vidéo")
            break
        
        # Afficher les informations sur le frame
        cv2.putText(frame, "$($AppConfig.display_name)", (10, 30), 
                   cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
        cv2.putText(frame, "Appuyez sur 'q' pour quitter", (10, 70), 
                   cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255, 255, 255), 2)
        
        # Afficher le frame
        cv2.imshow('$($AppConfig.display_name)', frame)
        
        # Vérifier si l'utilisateur appuie sur 'q'
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
    
    # Libérer les ressources
    cap.release()
    cv2.destroyAllWindows()
    print("Application fermée proprement")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nApplication interrompue par l'utilisateur")
        sys.exit(0)
    except Exception as e:
        print(f"Erreur: {e}")
        sys.exit(1)
"@
        Set-Content -Path $MainFilePath -Value $PythonContent -Encoding UTF8
        Write-ColoredOutput "    ✓ Fichier Python généré: $MainFilePath" "Green"
    }
    
    # Générer le fichier requirements.txt
    $RequirementsPath = Join-Path $AppPath "requirements.txt"
    if (-not (Test-Path $RequirementsPath)) {
        $RequirementsContent = @"
# Dépendances pour $($AppConfig.display_name)
# Smart Board Application

# Vision par ordinateur
opencv-python==4.9.0.80
opencv-contrib-python==4.9.0.80

# Traitement d'images et calcul scientifique
numpy==1.24.3
pillow==10.0.0

# Interface utilisateur
tkinter

# Gestion des fichiers multimédia
imageio==2.31.1

# Utilitaires
requests==2.31.0
"@
        Set-Content -Path $RequirementsPath -Value $RequirementsContent -Encoding UTF8
        Write-ColoredOutput "    ✓ Fichier requirements.txt généré: $RequirementsPath" "Green"
    }
    
    # Générer le fichier tutorial.url
    $TutorialPath = Join-Path $AppPath "tutorial.url"
    if (-not (Test-Path $TutorialPath)) {
        $TutorialContent = @"
[InternetShortcut]
URL=https://github.com/web-app-ia/SMART-BOARD-CONTENU/wiki/$($AppName)
"@
        Set-Content -Path $TutorialPath -Value $TutorialContent -Encoding UTF8
        Write-ColoredOutput "    ✓ Fichier tutorial.url généré: $TutorialPath" "Green"
    }
}

function Main {
    Write-ColoredOutput "================================================" "Cyan"
    Write-ColoredOutput "    SMART BOARD MANAGER - v1.0.0" "Cyan"
    Write-ColoredOutput "================================================" "Cyan"
    Write-ColoredOutput ""
    
    if ($Action -eq "generate") {
        Write-ColoredOutput "Génération des applications Smart Board..." "White"
        Write-ColoredOutput ""
        
        foreach ($Category in $Applications.Keys) {
            Write-ColoredOutput "Catégorie: $($Applications[$Category].display_name)" "Magenta"
            
            foreach ($AppName in $Applications[$Category].apps.Keys) {
                $AppConfig = $Applications[$Category].apps[$AppName]
                Generate-ApplicationFiles -Category $Category -AppName $AppName -AppConfig $AppConfig
            }
            Write-ColoredOutput ""
        }
        
        Write-ColoredOutput "✓ Génération terminée avec succès !" "Green"
    }
    else {
        Write-ColoredOutput "Action non reconnue: $Action" "Red"
        Write-ColoredOutput "Actions disponibles: generate" "Yellow"
    }
}

# Exécution
Main
