# Configuration WSL

Cette procédure vous aidera à configurer votre système pour supporter l'exécution de containers ARM par l'intermédiaire de l'émulateur QEMU.

> **Attention!**  
Si Docker Desktop est déjà installé, vous êtes déjà prêt à utiliser le container !

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

## Erreurs potentielles
### Aucune distribution de linux n'a été installée dans WSL / `wsl --install` ne fonctionne pas:
1. Redémarrez l'ordinateur.  

---

### Failed with error: Command failed: wsl --install -d Ubuntu
1. Vous devez activer la virtualisation dans le bios.