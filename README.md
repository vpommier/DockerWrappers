# DockerWrappers
Run containerized commands through powershell.

## Description
Example of commands that are containerized in docker images that i run through a powershell function.
These functions are grouped in a powershell module.

## Dependancies
* Powershell
* Git

## Installation
In your terminal (git bash):
```bash
git clone https://github.com/vpommier/DockerWrappers.git $HOME/Documents/WindowsPowerShell/Modules/DockerWrappers
```

In your powershell console:
```powershell
Import-Module DockerWrappers
```

## Usage
Powershell public function are listed in the module manifest (DockerWrappers.psd1).

Example with awscli:
```powershell
Start-AwsCli help
```

Another one with docker-compose:
```powershell
docker-compose
```
