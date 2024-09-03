FROM debian:12
ENV NOVNC_VERSION="v1.5.0"

ENV DEBIAN_FRONTEND=noninteractive 

USER 0

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openbox tint2 xdg-utils lxterminal hsetroot tigervnc-standalone-server tigervnc-tools supervisor && \
    rm -rf /var/lib/apt/lists

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends vim openssh-client wget curl rsync ca-certificates htop tar xzip gzip bzip2 zip unzip git && \
    rm -rf /var/lib/apt/lists

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends sudo firefox-esr && \
    rm -rf /var/lib/apt/lists

RUN git clone https://github.com/novnc/noVNC --branch ${NOVNC_VERSION} /noVNC


COPY supervisord.conf /etc/
COPY menu.xml /etc/xdg/openbox/
RUN echo 'hsetroot -solid "#123456" &' >> /etc/xdg/openbox/autostart

RUN mkdir -p /etc/firefox
RUN echo 'pref("browser.tabs.remote.autostart", false);' >> /etc/firefox/syspref.js

#RUN mkdir -p /root/.config/tint2
#COPY tint2rc /root/.config/tint2/

EXPOSE 8080
RUN useradd -ms /bin/bash vncuser
RUN passwd -d vncuser
RUN usermod -aG sudo vncuser
RUN chown vncuser:vncuser /noVNC -R

WORKDIR /home/vncuser
ADD run.sh .
RUN chmod +x run.sh

USER vncuser

EXPOSE 8080

CMD ["./run.sh"]
