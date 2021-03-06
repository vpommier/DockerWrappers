#
# Manifeste de module pour le module « DockerWrappers »
#
# Généré par : vince
#
# Généré le : 02/09/2015
#

@{

# Module de script ou fichier de module binaire associé à ce manifeste
RootModule = 'DockerWrappers.psm1'

# Numéro de version de ce module.
ModuleVersion = '1.0'

# ID utilisé pour identifier de manière unique ce module
GUID = 'b9f52126-6c22-4250-be1a-6073e31fdfdf'

# Auteur de ce module
Author = 'Vincent POMMIER'

# Société ou fournisseur de ce module
CompanyName = 'vpommier'

# Déclaration de copyright pour ce module
Copyright = '(c) 2015 vpommier. Tous droits réservés.'

# Description de la fonctionnalité fournie par ce module
Description = 'Docker commands wrapper.'

# Version minimale du moteur Windows PowerShell requise par ce module
# PowerShellVersion = ''

# Nom de l'hôte Windows PowerShell requis par ce module
# PowerShellHostName = ''

# Version minimale de l'hôte Windows PowerShell requise par ce module
# PowerShellHostVersion = ''

# Version minimale du Microsoft .NET Framework requise par ce module
# DotNetFrameworkVersion = ''

# Version minimale de l'environnement CLR (Common Language Runtime) requise par ce module
# CLRVersion = ''

# Architecture de processeur (None, X86, Amd64) requise par ce module
# ProcessorArchitecture = ''

# Modules qui doivent être importés dans l'environnement global préalablement à l'importation de ce module
# RequiredModules = @()

# Assemblys qui doivent être chargés préalablement à l'importation de ce module
# RequiredAssemblies = @()

# Fichiers de script (.ps1) exécutés dans l’environnement de l’appelant préalablement à l’importation de ce module
# ScriptsToProcess = @()

# Fichiers de types (.ps1xml) à charger lors de l'importation de ce module
# TypesToProcess = @()

# Fichiers de format (.ps1xml) à charger lors de l'importation de ce module
# FormatsToProcess = @()

# Modules à importer en tant que modules imbriqués du module spécifié dans RootModule/ModuleToProcess
# NestedModules = @()

# Fonctions à exporter à partir de ce module
FunctionsToExport = 'Start-IdeAws', 'Start-IdeTerraform', 'Start-AwsCLi', 'Start-DockerVM', 'Destroy-DockerVM', 'docker-compose'

# Applets de commande à exporter à partir de ce module
# CmdletsToExport = '*'

# Variables à exporter à partir de ce module
# VariablesToExport = '*'

# Alias à exporter à partir de ce module
# AliasesToExport = '*'

# Liste de tous les modules empaquetés avec ce module
# ModuleList = @()

# Liste de tous les fichiers empaquetés avec ce module
# FileList = @()

# Données privées à transmettre au module spécifié dans RootModule/ModuleToProcess
# PrivateData = ''

# URI HelpInfo de ce module
# HelpInfoURI = ''

# Le préfixe par défaut des commandes a été exporté à partir de ce module. Remplacez le préfixe par défaut à l’aide d’Import-Module -Prefix.
# DefaultCommandPrefix = ''

}

