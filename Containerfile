FROM quay.io/toolbx-images/ubuntu-toolbox:rolling

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="Tuomas Tielinen"

COPY extra-packages /
RUN apt update && \
      apt upgrade -y && \
      grep -v '^#' /extra-packages | xargs apt install -y
RUN rm /extra-packages

RUN git clone https://mpr.makedeb.org/just && \
      cd just && \
      makedeb -si

RUN curl -sS https://starship.rs/install.sh | sh

RUN sh -c "$(curl -fsLS get.chezmoi.io)"

RUN   ln -fs /bin/sh /usr/bin/sh && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/transactional-update

