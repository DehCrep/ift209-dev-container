ARM_DEBUG_PORT="1234"

# Pour lancer une application ARM.
arm-run () {
    qemu-aarch64 -L /usr/aarch64-linux-gnu ${1}
}

# Pour démarrer une application ARM et lancer le server de débogage.
arm-debug () {
    qemu-aarch64 -L /usr/aarch64-linux-gnu/ -g $ARM_DEBUG_PORT ${1}
}

# Pour lancer le débogeur ARM.
arm-debug-file () {
    gdb-multiarch -q --nh -ex 'set architecture aarch64' -ex "file ${1}" -ex "target remote localhost:$ARM_DEBUG_PORT"
}

# Des petits alias pour simplifier l'appel des fonctions déclarées ci-haut...
alias ar="arm-run"
alias adb="arm-debug"
alias adbf="arm-debug-file"