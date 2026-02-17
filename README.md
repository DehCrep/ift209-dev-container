# Développement ASM ARM sur x86

![Visual Studio Code en plein débogage ASM ARM.](images/debug-preview.png)

Ce projet a été fait avec amour pour les élèves de l'Université de Sherbooke en tant qu'alternative plus légère et portable que la solution de développement offerte en classe.

## Pré-requis

Le Dev Container de ce projet est configuré spécifiquement pour permettre le développement assembleur aarch64 sur les ordinateurs x86.

### Visual Studio Code
1. Installer Visual Studio Code à partir du [site officiel](https://code.visualstudio.com/download).
2. Installer l'extension suivante dans *Visual Studio Code*:
    - [Remote Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### Docker
1. Suivre les instructions d'installation à partir du [site officiel](https://docs.docker.com/engine/install/). Pour une installation plus facile, installer [Docker Desktop](https://www.docker.com/products/docker-desktop/).

> **Utilisateurs Windows:** Pour un installation plus légère, installer manuellement WSL et Docker avec les instructions dans [ce document](/wsl-configuration.md).


## Utiliser le Dev Container
1. Télécharger la dernière version du Dev Container [ici](https://github.com/DehCrep/IFT209-DevContainer/releases/latest).
1. Dézipper la dans le même dossier que votre projet. *Les dossiers [`.devcontainer`](.devcontainer) [`.vscode`](.vscode) devraient se trouver à sa racine.*

2. Ouvrir votre dossier de travail avec *Visual Studio Code*. Celui-ci devrait vous proposer de rouvrir le dossier dans le DevContainer. Faites-le!
*Vous pouvez forcer Visual Studio Code à lancer le Dev Container en appuyant sur `f1` et en sélectionnant `Dev Containers: Reopen in Container`.*

> **Remarque:** Au premier lancement, Docker téléchargera les fichiers nécéssaires pour l'exécution de l'environnement de développement. Ça prendra quelques minutes. Vous verrez apparaître vos fichiers dans l'explorateur à gauche lorsque le processus sera fini. Le libellé du ruban bleu en bas à gauche devrait aussi indiquer `armdevenv`.

La page va se recharger et vous verrez plusieurs lignes défiler dans un terminal au bas de l'écran.

### Sommaire des alias

Des alias ont été créés pour faciliter les tâches principales de l'environnement de développement.

|Alias|Commande|
|:--|:--|
|`as`|`aarch64-linux-gnu-as`|
|`ld`|`aarch64-linux-gnu-ld`|
|`gcc`|`aarch64-linux-gnu-gcc`|
|`ar`|`arm-run`|
|`adb`|`arm-debug`|
|`adbg`|`arm-debugger`|

### Commandes spéciales

Des commandes ont été créées pour trivialiser l'utilisation de QEMU et de gdb.

|Commande|Argument|Fonction|
|:--|:--|:--|
|`arm-run`|Nom du fichier à exécuter.|Exécute un programme avec QEMU.|
|`arm-debug`|Nom du fichier à déboguer.|Exécute un programme et le serveur de déboguage avec QEMU sur le port `1234`.|
|`arm-debugger`|Nom du fichier à déboguer.|Exécute gdb de façon à le connecter au port `1234`.|

## Compiler un programme

Le container vient préinstallé avec des outils de cross-compilation. Il est aussi configurer pour rendre leur utilisation transparente avec des alias.
|Alias|Programme|
|:--|:--|
|`as`|`aarch64-linux-gnu-as`|
|`ld`|`aarch64-linux-gnu-ld`|
|`gcc`|`aarch64-linux-gnu-gcc`|

*Exemple d'utilisation:*
```bash
#aarch64-linux-gnu-as --gstabs ./prog.as -o ./prog.o
# même chose que:
as -g ./prog.as -o ./prog.o

#aarch64-linux-gnu-ld -e Main ./prog.o  -o ./prog -lc
# même chose que:
ld -e Main ./prog.o  -o ./prog -lc

#aarch64-linux-gnu-gcc ...
# même chose que:
gcc ...
```

Vous pouvez compiler les projets qui ont un makefile sans soucis, puisque `make` prend aussi en compte les alias.
```bash
# En ayant cd le répertoire d'un Makefile.
make
```

## Exécution

Vous ne pouvez pas directement lancer un programme de la même façon que la machine virtuelle de l'école.

Utilisez plutôt la fonction `arm-run [file]` ou son alias `ar [file]`:
```bash
#arm-run ./prog
# Même chose que:
ar ./prog
```

## Débogage

QEMU ne supporte pas le débogage avec gdb nativement, mais nous pouvons contourner cette limitation par le biais d'un serveur de débogage:


1. Dans un premier terminal, lancer d'abord votre programme avec la fonction `arm-debug [file]` ou son alias `adb [file]`.
    ```bash
    #arm-debug ./prog
    # Même chose que:
    adb ./prog
    ```
    Vous remarquerez que votre programme semble être en pause. **C'est le cas!** Il attend le signal du débogueur pour commencer son exécution.

2. Dans un deuxième terminal, lancer le débogueur avec la commande `arm-debugger [file]` ou son alias `adbg [file]`.
    ```bash
    #arm-debugger ./prog
    # Même chose que:
    adbg ./prog
    ```
    N'utiliser pas la commande `run` pour lancer le programme, puisqu'il est déjà en cours d'exécution.

    Vous êtes maintenant en train de déboguer votre programme. Utilisez toutes les commandes de GDB que vous voulez (quel plaisir!)

## Débogage visuel (Visual Studio Code)

Le débogage visuel réduit en un simple clic le processus de lancement et d'analyse de programmes asm.

1. Compiler d'abord votre programme manuellement. Nous aurons besoin de son exécutable.


> **Attention :** Assurez-vous que vous compilez avec l'argument `-g` ([plutôt que `-gstabs`](https://github.com/DehCrep/IFT209-DevContainer/issues/18)).

2. Dans l'onglet **Run and Debug**, Choisir le [profil de débogage](https://code.visualstudio.com/docs/debugtest/debugging) qui vous convient et appuyez sur `f5` pour démarrer la session de débogage.
    - Utiliser **(QEMU + gdb) debug current file** (par défaut) pour déboguer l'exécutable qui porte le même nom que le fichier source actuellement ouvert. Par exemple, si votre fichier source s'appelle `prog.as`, VS Code lancera automatiquement le programme intitulé `prog` dans le même répertoire.

    - Utiliser **(QEMU + gdb) debug selected file** pour déboguer un exécutable et lui passer des arguments. Vous serez invités à enter 2 paramètres:

        |Paramètre|Quoi fournir|
        |:--|:--|
        |**arm-debugger argument**|Le nom de l'exécutable relatif au fichier actuellement ouvert. (ex: `prog`)|
        |**arm-debug argument**|Le nom de l'exécutable relatif au fichier actuellement ouvert. *Vous pouvez y ajouter des arguments ainsi que lui fournir une redirection d'entrées. (ex: `prog < tests/input_file`)*|

    > **Attention :** Le programme commencera toujours son exécution hors de votre fichier. C'est un caprice de l'émulation QEMU (je pense). Vous verrez un nouveau fichier inexistant s'ouvrir. Vous pouvez le fermer et rouvrir le fichier source de l'exécutable courant.

### Ajouter des points d'arrêt
Ajoutez des points d'arrêts directement dans votre fichier source (au `Main`, par exemple) et utilisez [la barre d'outils de débogage](https://code.visualstudio.com/docs/debugtest/debugging#_debug-actions) pour contrôler l'exécution de votre programme.

### Consulter les registres
Lorsque l'exécution est en pause, les registres et leurs valeurs sont disponibles dans [le panneau de gauche](https://code.visualstudio.com/docs/debugtest/debugging#_data-inspection).

### Désassemblage du code
Vous pouvez consulter le code désassemblé de l'application en faisant un clic droit sur sur n'importe quel élément du call stack (dans le panneau de gauche) et en sélectionnant `Open Disassembly View`. *Vous pouvez même directement ajouter des breakpoints dans le code désassemblé!*

![Le panneau de disassembly dans Visual Studio Code](images/disassembly-preview.png)