FROM archlinux:latest
RUN pacman -Suy --noconfirm --needed git base-devel bc cpio libelf pahole xmlto github-cli ccache
RUN mkdir -p /home/builder/.cache/ccache
RUN useradd -m builder
RUN chown -R builder /home/builder
USER builder
RUN mkdir /home/builder/.config
COPY modprobed.db /home/builder/.config/modprobed.db
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
