# Configuration manuelle de WSL

Cette procédure vous aidera à installer WSL et configurer votre installation pour supporter l'exécution de containers ARM par l'intermédiaire de l'émulateur QEMU.

> **Attention!**  
Si Docker Desktop est déjà installé, référez-vous au guide [Configuration de Docker Desktop](setup-docker-desktop.md).


## Configurer votre ordinateur
1. Assurez-vous que la **virtualisation est activée** dans le BIOS. Cette étape est essentielle pour exécuter des machines virtuelles sur votre système.

## Configurer *Visual Studio Code*
1. Installez les extensions suivantes:
    - [Container Tools](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-containers).
    - [Remote Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
    - [WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl)

## Installer WSL
1. Ouvrez la fenêtre de modification des features de Windows en cliquant sur `win` + `r` pour ouvrir la fenêtre de lancement rapide, et en y entrant `optionalfeatures`.

2. Sélectionnez `Windows Subsystem For Linux` et cliquez sur **ok**. Vous serez invités à redémarer l'ordinateur. Faites-le!

3. Une console intitulée **wsl.exe** peut s'ouvrir après l'ouverture de votre session pour compléter l'installation. Appuyer sur `enter` et attendez que Windows télécharge et installe les composantes manquantes. Redémarrez l'ordinateur une dernière fois.

4. Ouvrez un nouveau terminal en cliquant sur `win` + `r` pour ouvrir la fenêtre de lancement rapide, et en y entrant `optionalfeatures`.

5. Entrez la commande suivante pour installer la distribution par défaut (Ubuntu)
```bash
wsl --install
```

6. Configurez votre utilisateur Unix par défaut (Si le terminal ne vous le propose pas automatiquement, rouvrez wsl en entrant la commande `wsl` dans le terminal).

## Installer Docker dans WSL
1. Dans *Visual Studio Code*, appuyez sur `f1` et sélectionnez `Dev Containers: Install Docker in WSL`.  
*Docker devrait être installé et correctement configuré dans votre distribution de WSL.*

## Configurer la couche d'émulation
1. Dans *Visual Studio Code*, Appuyez sur `f1` et entrez `WSL: Connect to WSL`. L'IDE devrait se recharger et vous verrez en bas à gauche de l'application un ruban bleu libellé avec le nom de votre distribution.

2. Copiez le service [qemu-binfmt.service](qemu-binfmt.service) (à partir de ce dépôt)  sous le dossier suivant: `/etc/systemd/system/qemu-binfmt.service`.
```bash
# En Ayant cd la racine du dépôt
sudo cp ./qemu-binfmt.service /etc/systemd/system/
```

3. Activez le service de façon permanente:
```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable qemu-binfmt
sudo systemctl start qemu-binfmt
```

- **Alternativement,**  si vous ne voulez pas bisouiller avec les services, ne faites qu'exécuter la ligne suivante à chaque lancement:
    ```bash
    docker run --privileged --rm tonistiigi/binfmt --install arm64
    ```

## Eureka !
Tout devrait être correctement configuré. Référez-vous à la section [Utiliser le Dev Container](./README.md/#utiliser-le-dev-container) de la page principale pour savoir comment utiliser le Dev Container. Si vous rencontrez des erreurs lors du lancement du DevContainer, référez-vous à la section suivante: [Erreurs potentielles](#erreurs-potentielles).

## Erreurs potentielles
### Aucune distribution de linux n'a été installée dans WSL / `wsl --install` ne fonctionne pas:
1. Redémarrez l'ordinateur.  

---

### Failed with error: Command failed: wsl --install -d Ubuntu
1. Vous devez activer la virtualisation dans le bios.

---

### Erreurs de lancement du dev container.
```log
WARNING: The requested image's platform (linux/arm64) does not match the detected host platform (linux/amd64/v3) and no specific platform was requested
exec /bin/sh: exec format error
```
1. Assurez-vous d'avoir bien suivi les instructions sous [Configurer la couche d'émulation](#configurer-la-couche-démulation).

---

### Failed to start qemu-binfmt.service: Unit docker.service not found


1. Ouvrez un nouveau terminal dans *Visual Studio Code* connecté à WSL.
2. Regardez si le terminal WSL vous laisse utiliser Docker avec cette commande:
```bash
docker
```
Si vous recevez un message d'erreur comme suit:
```
The command 'docker' could not be found in this WSL 2 distro.
We recommend to activate the WSL integration in Docker Desktop settings.
...
```