FROM archlinux:latest
RUN pacman -Suy --noconfirm --needed git base-devel bc cpio libelf pahole xmlto github-cli
RUN useradd -m linux-clear_builder
USER linux-clear_builder
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]