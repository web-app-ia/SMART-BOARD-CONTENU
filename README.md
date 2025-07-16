# Smart Board - Contenu et Applications

![Smart Board Logo](https://img.shields.io/badge/Smart%20Board-v1.0.0-blue)
![Python](https://img.shields.io/badge/Python-3.8%2B-green)
![Windows](https://img.shields.io/badge/Platform-Windows-lightgrey)

## Description

Ce repository contient toutes les applications Python spécialisées pour **Smart Board App**, incluant les modules d'IA, de vision par ordinateur et d'interaction utilisateur.

## 🚀 Nouvelle Architecture (v1.0.0)

Cette version introduit une architecture révolutionnaire avec :

- ✅ **Template .bat universel** pour tous les lanceurs
- ✅ **Génération automatique** des scripts de lancement
- ✅ **Configuration multi-ordinateurs** adaptable
- ✅ **Déploiement automatisé** avec scripts PowerShell

## 📁 Structure du Repository

```
SMART-BOARD-CONTENU/
├── 📂 body_tracking/           # Applications de suivi corporel
│   ├── 📂 pose_detection/
│   │   ├── 🚀 launch_pose_detection_admin.bat
│   │   ├── 🐍 main.py
│   │   ├── 📋 requirements.txt
│   │   └── 🌐 tutorial.url
│   └── 📂 gesture_control/
│       ├── 🚀 launch_gesture_control_admin.bat
│       ├── 🐍 main.py
│       ├── 📋 requirements.txt
│       └── 🌐 tutorial.url
├── 📂 gestures/                # Gestuelle des mains
│   ├── 📂 hand_tracking/
│   │   ├── 🚀 launch_hand_tracking_admin.bat
│   │   ├── 🐍 main.py
│   │   ├── 📋 requirements.txt
│   │   └── 🌐 tutorial.url
│   └── 📂 finger_counter/
│       ├── 🚀 launch_finger_counter_admin.bat
│       ├── 🐍 main.py
│       ├── 📋 requirements.txt
│       └── 🌐 tutorial.url
├── 📂 Réalité virtuelle/       # Applications AR/VR
│   ├── 📂 ar_overlay/
│   │   ├── 🚀 launch_ar_overlay_admin.bat
│   │   ├── 🐍 main.py
│   │   ├── 📋 requirements.txt
│   │   └── 🌐 tutorial.url
│   └── 📂 virtual_objects/
│       ├── 🚀 launch_virtual_objects_admin.bat
│       ├── 🐍 app.py
│       ├── 📋 requirements.txt
│       └── 🌐 tutorial.url
├── 📂 resources/              # Ressources pédagogiques
│   ├── 📂 math_tools/
│   │   ├── 🚀 launch_math_tools_admin.bat
│   │   ├── 🐍 main.py
│   │   ├── 📋 requirements.txt
│   │   └── 🌐 tutorial.url
│   └── 📂 science_sim/
│       ├── 🚀 launch_science_sim_admin.bat
│       ├── 🐍 main.py
│       ├── 📋 requirements.txt
│       └── 🌐 tutorial.url
├── 📂 voice_assistant/        # Assistant vocal
│   ├── 📂 speech_recognition/
│   │   ├── 🚀 launch_speech_recognition_admin.bat
│   │   ├── 🐍 main.py
│   │   ├── 📋 requirements.txt
│   │   └── 🌐 tutorial.url
│   └── 📂 voice_commands/
│       ├── 🚀 launch_voice_commands_admin.bat
│       ├── 🐍 main.py
│       ├── 📋 requirements.txt
│       └── 🌐 tutorial.url
├── 📂 whiteboards/            # Tableaux virtuels
│   ├── 📂 drawing_board/
│   │   ├── 🚀 launch_drawing_board_admin.bat
│   │   ├── 🐍 main.py
│   │   ├── 📋 requirements.txt
│   │   └── 🌐 tutorial.url
│   └── 📂 collaborative_board/
│       ├── 🚀 launch_collaborative_board_admin.bat
│       ├── 🐍 main.py
│       ├── 📋 requirements.txt
│       └── 🌐 tutorial.url
├── 📂 config/                 # Configuration système
│   ├── ⚙️ deployment_config.json
│   └── ⚙️ adaptive_config.json
├── 📂 templates/              # Templates universels
│   └── 📄 universal_launcher_template.bat
├── 🔧 SmartBoard-Manager.ps1  # Gestionnaire principal
├── 📦 Install-SmartBoard.ps1  # Installation automatique
└── 📚 README.md               # Documentation
```

## 🔧 Installation

### Installation Automatique (Recommandée)

```powershell
# 1. Cloner le repository
git clone https://github.com/web-app-ia/SMART-BOARD-CONTENU.git

# 2. Lancer l'installation automatique
cd SMART-BOARD-CONTENU
powershell -ExecutionPolicy Bypass -File Install-SmartBoard.ps1
```

### Installation Manuelle

```powershell
# 1. Copier les dossiers vers %USERPROFILE%\smart-board-app\SMART_BOARD_Apps\
# 2. Générer les scripts de lancement
powershell -ExecutionPolicy Bypass -File SmartBoard-Manager.ps1
```

## 🎯 Applications Disponibles

### 🏃 Body Tracking
- **Détection de Pose** : Analyse des mouvements corporels en temps réel
- **Contrôle Gestuel** : Interaction par gestes du corps

### 👋 Gestures
- **Suivi des Mains** : Reconnaissance des mouvements de mains
- **Compteur de Doigts** : Comptage automatique des doigts

### 🥽 Réalité Virtuelle
- **AR Overlay** : Superposition d'éléments virtuels
- **Objets Virtuels** : Manipulation d'objets 3D

### 📚 Ressources
- **Outils Mathématiques** : Calculatrices et graphiques interactifs
- **Simulations Scientifiques** : Expériences virtuelles

### 🎤 Assistant Vocal
- **Reconnaissance Vocale** : Conversion parole-texte
- **Commandes Vocales** : Contrôle vocal de l'application

### 🎨 Tableaux
- **Tableau de Dessin** : Création artistique interactive
- **Tableau Collaboratif** : Travail en équipe

## 🚀 Utilisation

### Lancement d'une Application

Chaque application possède son propre script de lancement :

```batch
# Exemple pour le suivi des mains
cd gestures\hand_tracking\
launch_hand_tracking_admin.bat
```

### Contrôles Communs

- **Q** : Quitter l'application
- **S** : Sauvegarder les données (si applicable)
- **R** : Réinitialiser (si applicable)

## 🔧 Développement

### Ajouter une Nouvelle Application

1. Modifier `SmartBoard-Manager.ps1`
2. Ajouter la configuration dans `$Applications`
3. Exécuter la génération : `.\SmartBoard-Manager.ps1`

### Structure Standard d'une Application

```
mon_application/
├── launch_mon_application_admin.bat  # Script de lancement
├── main.py                          # Application principale
├── requirements.txt                 # Dépendances Python
└── tutorial.url                     # Lien vers la documentation
```

## ⚙️ Configuration

### Fichiers de Configuration

- **`config/deployment_config.json`** : Configuration de déploiement
- **`config/adaptive_config.json`** : Configuration adaptable
- **`templates/universal_launcher_template.bat`** : Template universel

### Variables d'Environnement

- `%USERPROFILE%\smart-board-app` : Répertoire de base
- `%USERPROFILE%\smart-board-app\smartboard_env310` : Environnement Python
- `%USERPROFILE%\smart-board-app\logs` : Fichiers de log

## 🛠️ Scripts PowerShell

### SmartBoard-Manager.ps1

Script principal de gestion :

```powershell
# Générer toutes les applications
.\SmartBoard-Manager.ps1

# Générer avec configuration spécifique
.\SmartBoard-Manager.ps1 -Action generate -ConfigPath "config\deployment_config.json"
```

### Install-SmartBoard.ps1

Script d'installation automatique :

```powershell
# Installation standard
.\Install-SmartBoard.ps1

# Installation avec chemin personnalisé
.\Install-SmartBoard.ps1 -InstallPath "C:\MonChemin\smart-board-app"

# Installation forcée (écrase existant)
.\Install-SmartBoard.ps1 -Force
```

## 📋 Prérequis

- **Python 3.8+** avec pip
- **Windows 10/11** avec PowerShell
- **Caméra web** (pour applications de vision)
- **Microphone** (pour applications vocales)
- **Privilèges administrateur** (pour l'installation)

## 🔄 Mise à Jour

```powershell
# Méthode 1 : Git pull
git pull origin main
.\SmartBoard-Manager.ps1

# Méthode 2 : Script de mise à jour
.\Update-SmartBoard.ps1
```

## 📞 Support

- **GitHub Issues** : [Signaler un problème](https://github.com/web-app-ia/SMART-BOARD-CONTENU/issues)
- **Wiki** : [Documentation complète](https://github.com/web-app-ia/SMART-BOARD-CONTENU/wiki)
- **Discussions** : [Forum communautaire](https://github.com/web-app-ia/SMART-BOARD-CONTENU/discussions)

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 🎉 Contributeurs

- **Développement Principal** : [web-app-ia](https://github.com/web-app-ia)
- **Architecture** : Smart Board Team
- **Tests** : Communauté Smart Board

---

**Smart Board** - Révolutionnez votre expérience d'interaction ! 🚀
