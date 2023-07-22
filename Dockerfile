FROM archlinux:latest
RUN pacman -Suyq --noconfirm --noprogressbar --overwrite --needed git base-devel bc cpio libelf pahole xmlto github-cli ccache 
RUN useradd -m builder
USER builder
RUN mkdir /home/builder/.config
COPY modprobed.db /home/builder/.config/modprobed.db
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
