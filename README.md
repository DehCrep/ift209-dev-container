# Développement ASM ARM sur x86

Ce projet a été fait avec amour pour les élèves de l'université de Sherbooke qui ne veulent pas faire leurs devoirs d'IFT209 sur les ordinateurs de l'école ou d'installer l'ÉNORME image de machine virtuelle de 15gb qui est littéralement impossible à télécharger (j'ai essayé 2 fois et j'ai abandonné).

Je vous prend donc par la main pour vous aider à configurer un environnement de développement assembly beaucoup plus légé et moderne que la solution proposée en cours.

## Mise en marche

Le DevContainer de ce projet est configuré pour exécuter une machine virtuelle ARM qui comporte les composantes logicielles requises pour compiler, debugger, et exécuter des applications ARM sur n'importe quelle autre architecture.

Pour une installation facile mais plus lourde, suivez les instructions dans [Configuration de *Docker Desktop*](setup-docker-desktop.md).

> Il est suggérer d'installer Docker Desktop sur votre appareil, puisque ça facilite énormément le processus de configuration.

Alternativement, vous pouvez configurer manuellement votre appareil pour supporter l'émulation de containers ARM en suivant les instructions dans les instructions dans [Configuration manuelle de WSL](setup-manually.md).


## Utiliser le Dev Container
1. Téléchargez la dernière version du DevContainer [ici](https://github.com/DehCrep/IFT209-DevContainer/releases/latest).
1. Dézippez la dans le même dossier que votre projet. *Le dossier [`.devcontainer`](.devcontainer) devrait se trouver à sa racine.*

2. Ouvrez votre dossier de travail avec *Visual Studio Code*. Celui-ci devrait vous proposer de rouvrir le dossier dans le DevContainer. Faites-le!  
Si vous ne voyez pas le prompt, assurez vous que le dossier [`.devcontainer`](.devcontainer) se situe bien à la racine de votre dossier de travail.  
*Vous pouvez forcer Visual Studio Code à lancer le Dev Container en appuyant sur `f1` et en sélectionnant `Dev Containers: Reopen in Container`.*

> **Remarque!**  
Au premier lancement, Docker téléchargera les fichiers nécéssaires pour l'exécution de l'environnement de développement ARM. Ça prendra quelques minutes. Vous verrez apparaître vos fichiers dans l'explorateur à gauche lorsque le processus sera fini. Le libellé du ruban bleu en bas à gauche devrait aussi indiquer `armdevenv`.


La page va se recharger et vous verrez plusieurs lignes défiler sur un terminal inférieur.

Ouvrez un nouveau terminal, compilez votre programme avec les commandes vues en classe et exécutez le comme si vous utilisiez une vraie machine ARM !

L'image de base du DevContainer vient préinstallée avec les outils nécéssaires à la compilation de code asm:
- `gdb`
- `gcc`
- `make` 
- `ld`
- `as`