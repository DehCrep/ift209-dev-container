# Pour lancer une application ARM.
arm-run () {
    exec qemu-aarch64 -L /usr/aarch64-linux-gnu ${1}
}

# Pour démarrer une application ARM et lancer le server de débogage.
arm-debug () {
    exec qemu-aarch64 -L /usr/aarch64-linux-gnu/ -g $DB_PORT ${1}
}

# Pour lancer le débogeur ARM.
arm-debugger () {
    exec gdb-multiarch -q --nh -ex 'set architecture aarch64' -ex "file ${1}" -ex "$DB_HOST:$DB_PORT"
}

# Des petits alias pour simplifier l'appel des fonctions déclarées ci-haut...
alias ar="arm-run"
alias adb="arm-debug"
alias adbg="arm-debugger"