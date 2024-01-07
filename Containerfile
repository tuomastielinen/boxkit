FROM quay.io/toolbx-images/ubuntu-toolbox:22.04

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="Tuomas Tielinen"

COPY extra-packages /

RUN apt-get update && \ 
      apt-get upgrade -y && \
      DEBIAN_FRONTEND=noninteractive apt-get -y install \
      $(cat /extra-packages | xargs) && \
      rm -rd /var/lib/apt/lists/*

RUN rm /extra-packages

RUN git clone https://mpr.makedeb.org/just && \
      cd just && \
      makedeb -si

RUN curl -sS https://starship.rs/install.sh | sh

RUN sh -c "$(curl -fsLS get.chezmoi.io)"

RUN   ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree