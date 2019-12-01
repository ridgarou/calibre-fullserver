
FROM linuxserver/calibre-web

LABEL maintainer="Ridgarou <ridgarou@gmail.com>" description="Calibre-Server with Calibre Web based on MephistoXoL (https://github.com/MephistoXoL/Docker-CalibreSrv-Web) image" version="multi.arch"

EXPOSE 8083

## INSTALL CALIBRE PACKAGES
RUN apt-get update && \
    apt-get install --no-install-recommends -y calibre cron 

## CLEAN PACKAGES
RUN apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
