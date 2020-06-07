FROM python:3.7.7-slim-buster

ENV DEBIAN_FRONTEND noninteractive

RUN  apt-get update && \
     apt-get install -y wget apt-transport-https apt-utils ca-certificates locales && \
     apt-get update

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN  apt-get install -y gstreamer1.0-pulseaudio gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gir1.2-gst-plugins-base-1.0 gir1.2-gstreamer-1.0
RUN  apt-get install -y libcairo2-dev libjpeg-dev libgif-dev libgirepository1.0-dev \
     python3-gst-1.0 python3-tornado python3-pkg-resources python3-pykka python3-requests python3-pip && \
     pip install PyGObject Mopidy Mopidy-TuneIn Mopidy-Mobile Mopidy-RadioWorld && \
     apt-get purge -y libcairo2-dev libjpeg-dev libgif-dev libgirepository1.0-dev python3-pip && \
     apt-get autoremove -y && \
     apt-get autoclean -y
        # Mopidy-GMusic Mopidy-YouTube  

COPY mopidy.conf /root/.config/mopidy_default.conf
COPY mopidy.sh /usr/local/bin/mopidy.sh

ENV PULSE_SERVER 127.0.0.1

EXPOSE 6680
ENTRYPOINT ["/usr/local/bin/mopidy.sh"]

