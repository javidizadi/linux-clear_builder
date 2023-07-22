FROM archlinux:latest
# RUN pacman -Suy --noconfirm --overwrite --needed git base-devel bc cpio libelf pahole xmlto github-cli ccache > /dev/null
RUN useradd -m builder
USER builder
RUN mkdir /home/builder/.config
COPY modprobed.db /home/builder/.config/modprobed.db
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
