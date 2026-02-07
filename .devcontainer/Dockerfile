# Se baser sur la dernière version LTS d'ubuntu
FROM ubuntu

# Installer tous les paquets nécéssaires pour la cross-compilation
RUN apt-get update && \
apt-get install -y \
gcc-aarch64-linux-gnu \
binutils-aarch64-linux-gnu \
binutils-aarch64-linux-gnu-dbg \
qemu-user \
qemu-user-static \
binfmt-support \
gdb-multiarch \
make

# Copier le dossier .devcontainer/tools dans le container sous /root/.../tools
COPY ./tools /root/SOURCES/ift209/tools

# Paramètres du serveur de débogage
ENV DB_HOST=localhost
ENV DB_PORT=1234

# des alias pour binder les outils de cross-compilation aux noms natifs (make files du prof)
RUN ln -s /usr/bin/aarch64-linux-gnu-as /usr/bin/as
RUN ln -s /usr/bin/aarch64-linux-gnu-ld /usr/bin/ld
RUN ln -s /usr/bin/aarch64-linux-gnu-gcc /usr/bin/gcc

# Copier le contenu de extra.bashrc dans le bashrc
COPY ./extra.bashrc /extra.bashrc
RUN cat /extra.bashrc >> ~/.bashrc && rm /extra.bashrc