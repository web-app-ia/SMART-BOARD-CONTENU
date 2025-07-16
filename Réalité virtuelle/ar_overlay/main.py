#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
Smart Board Application: Overlay AR
Category: Réalité Augmentée/Virtuelle
Generated automatically by SmartBoard-Manager.ps1
'''

import cv2
import numpy as np
import sys
import os

def main():
    '''
    Application principale pour Overlay AR
    '''
    print("=" * 60)
    print(f"    SMART BOARD - Overlay AR")
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
        cv2.putText(frame, "Overlay AR", (10, 30), 
                   cv2.FONT_HERSHEY_SIMPLEX, 1, (0, 255, 0), 2)
        cv2.putText(frame, "Appuyez sur 'q' pour quitter", (10, 70), 
                   cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255, 255, 255), 2)
        
        # Afficher le frame
        cv2.imshow('Overlay AR', frame)
        
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
