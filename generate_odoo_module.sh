#!/bin/bash

# Fonction pour valider le nom du module (doit être en snake_case)
validate_module_name() {
    local name=$1
    if [[ ! $name =~ ^[a-z][a-z0-9_]*$ ]]; then
        echo "Erreur : Le nom du module doit être en snake_case (lettres minuscules, chiffres, underscores, commence par une lettre)"
        exit 1
    fi
}

# Demander les informations du module
echo "Création d'un nouveau module Odoo"
echo "--------------------------------"

read -p "Nom du module (en snake_case, ex: my_module) : " module_name
validate_module_name "$module_name"

read -p "Version du module (ex: 1.0.0) : " version
version=${version:-"1.0.0"}

read -p "Description du module : " description
description=${description:-"Module Odoo généré automatiquement"}

read -p "Nom de l'auteur : " author
author=${author:-"Auteur"}

read -p "Version d'Odoo ciblée (ex: 16.0) : " odoo_version
odoo_version=${odoo_version:-"16.0"}

# Créer la structure de dossiers
mkdir -p "$module_name"/{models,controllers,views,security,data}

# Créer __init__.py
cat > "$module_name/__init__.py" << EOL
from . import models
from . import controllers
EOL

# Créer __manifest__.py
cat > "$module_name/__manifest__.py" << EOL
{
    'name': '$module_name',
    'version': '$version',
    'summary': '$description',
    'description': """
        $description
    """,
    'author': '$author',
    'depends': ['base'],
    'data': [
        'security/ir.model.access.csv',
        'views/${module_name}_views.xml',
        'data/${module_name}_data.xml',
    ],
    'installable': True,
    'auto_install': False,
    'application': False,
}
EOL

# Créer un modèle de base
cat > "$module_name/models/__init__.py" << EOL
from . import ${module_name}
EOL

cat > "$module_name/models/${module_name}.py" << EOL
from odoo import models, fields

class ${module_name^}(models.Model):
    _name = '${module_name}.${module_name}'
    _description = '$description'

    name = fields.Char(string='Name', required=True)
    description = fields.Text(string='Description')
EOL

# Créer un fichier de vues
cat > "$module_name/views/${module_name}_views.xml" << EOL
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <record id="${module_name}_tree_view" model="ir.ui.view">
        <field name="name">${module_name}.tree</field>
        <field name="model">${module_name}.${module_name}</field>
        <field name="arch" type="xml">
            <tree>
                <field name="name"/>
                <field name="description"/>
            </tree>
        </field>
    </record>

    <record id="${module_name}_form_view" model="ir.ui.view">
        <field name="name">${module_name}.form</field>
        <field name="model">${module_name}.${module_name}</field>
        <field name="arch" type="xml">
            <form>
                <sheet>
                    <group>
                        <field name="name"/>
                        <field name="description"/>
                    </group>
                </sheet>
            </form>
        </field>
    </record>

    <record id="${module_name}_action" model="ir.actions.act_window">
        <field name="name">${module_name^}</field>
        <field name="res_model">${module_name}.${module_name}</field>
        <field name="view_mode">tree,form</field>
    </record>

    <menuitem id="${module_name}_menu" name="${module_name^}"
              action="${module_name}_action"
              parent="base.menu_custom"/>
</odoo>
EOL

# Créer un fichier de sécurité
cat > "$module_name/security/ir.model.access.csv" << EOL
id,name,model_id:id,group_id:id,perm_read,perm_write,perm_create,perm_unlink
access_${module_name},${module_name},model_${module_name}_${module_name},base.group_user,1,1,1,1
EOL

# Créer un fichier de données
cat > "$module_name/data/${module_name}_data.xml" << EOL
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <data noupdate="1">
        <!-- Données initiales du module -->
    </data>
</odoo>
EOL

# Créer un fichier README
cat > "$module_name/README.md" << EOL
# $module_name

$description

## Installation
1. Copiez le dossier \`$module_name\` dans votre dossier d'addons Odoo
2. Mettez à jour la liste des modules dans Odoo
3. Installez le module \`$module_name\`

## Dépendances
- Odoo $odoo_version

## Auteur
$author
EOL

echo "Module Odoo '$module_name' créé avec succès !"
echo "Structure générée :"
tree "$module_name" || ls -R "$module_name"
echo "Prochaines étapes :"
echo "1. Copiez le dossier '$module_name' dans votre dossier d'addons Odoo"
echo "2. Mettez à jour la liste des modules dans Odoo"
echo "3. Installez le module via l'interface Odoo"