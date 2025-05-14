# Script de Création de Module Odoo

Ce script Bash (`create_odoo_module.sh`) automatise la création de la structure de base d'un module Odoo. Il demande les informations nécessaires à l'utilisateur et génère les dossiers et fichiers essentiels pour un module Odoo fonctionnel.

## Prérequis

- Un environnement Unix-like (Linux, macOS, WSL sur Windows)
- Bash installé
- Commande `tree` (optionnelle, pour afficher la structure des dossiers)
- Connaissance de base d'Odoo pour utiliser le module généré

## Utilisation

1. **Enregistrez le script** :

   - Copiez le contenu du script dans un fichier nommé `create_odoo_module.sh`.

2. **Rendez le script exécutable** :

   ```bash
   chmod +x create_odoo_module.sh
   ```

3. **Exécutez le script** :

   ```bash
   ./create_odoo_module.sh
   ```

4. **Suivez les invites** :

   - **Nom du module** : Entrez un nom en snake_case (ex. `my_module`). Il doit commencer par une lettre minuscule et ne contenir que des lettres minuscules, chiffres ou underscores.
   - **Version du module** : Indiquez la version (ex. `1.0.0`). Par défaut : `1.0.0`.
   - **Description** : Fournissez une courte description du module. Par défaut : "Module Odoo généré automatiquement".
   - **Auteur** : Entrez le nom de l'auteur. Par défaut : "Auteur".
   - **Version d'Odoo** : Spécifiez la version d'Odoo ciblée (ex. `16.0`). Par défaut : `16.0`.

5. **Vérifiez la structure générée** :

   - Le script crée un dossier portant le nom du module avec les sous-dossiers et fichiers suivants :
     - `__init__.py` : Fichier d'initialisation Python.
     - `__manifest__.py` : Fichier de manifeste du module Odoo.
     - `models/` : Contient un modèle de base.
     - `controllers/` : Dossier pour les contrôleurs (vide par défaut).
     - `views/` : Contient une vue de base (liste et formulaire).
     - `security/` : Contient un fichier CSV pour les droits d'accès.
     - `data/` : Contient un fichier XML pour les données initiales.
     - `README.md` : Documentation du module généré.
   - Une arborescence est affichée (si `tree` est installé) ou une liste des fichiers.

6. **Utilisez le module généré** :
   - Copiez le dossier du module dans le dossier `addons` de votre installation Odoo.
   - Mettez à jour la liste des modules dans Odoo (via l'interface ou la commande `odoo -u all`).
   - Installez le module via l'interface Odoo.

## Exemple

```bash
$ chmod +x create_odoo_module.sh
$ ./create_odoo_module.sh
Création d'un nouveau module Odoo
--------------------------------
Nom du module (en snake_case, ex: my_module) : test_module
Version du module (ex: 1.0.0) : 1.0.0
Description du module : Un module de test
Nom de l'auteur : Jean Dupont
Version d'Odoo ciblée (ex: 16.0) : 16.0
Module Odoo 'test_module' créé avec succès !
```

## Personnalisation

- Modifiez les fichiers générés dans le dossier du module pour ajouter des fonctionnalités spécifiques (modèles, vues, etc.).
- Consultez la documentation officielle d'Odoo pour des personnalisations avancées.

## Limitations

- Le script génère une structure de base. Des ajustements manuels sont nécessaires pour des fonctionnalités complexes.
- La validation du nom du module impose le format snake_case pour respecter les conventions Odoo.
- Compatible principalement avec Odoo 16.0 par défaut, mais adaptable via l'entrée de la version.

## Auteur

Grok, créé par xAI
