FROM archlinux:latest
RUN pacman -Suy --noconfirm --needed git base-devel bc cpio libelf pahole xmlto github-cli
RUN useradd -m linux-clear_builder
USER linux-clear_builder
RUN mkdir .config
COPY modprobed.db /home/linux-clear_builder/.config/modprobed.db
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]