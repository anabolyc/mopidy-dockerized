FROM python:3.8-slim-bullseye

ENV DEBIAN_FRONTEND noninteractive

RUN  apt-get update && \
     apt-get install -y wget apt-transport-https apt-utils ca-certificates locales && \
     apt-get update && \
     echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
     locale-gen en_US.UTF-8 && \
     dpkg-reconfigure locales && \
     /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8

RUN  apt-get install -y cmake gstreamer1.0-pulseaudio gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gir1.2-gst-plugins-base-1.0 gir1.2-gstreamer-1.0 \
     libcairo2-dev libjpeg-dev libgif-dev libgirepository1.0-dev \
     python3-gst-1.0 python3-tornado python3-pkg-resources python3-pykka python3-requests python3-pip && \
     pip install PyGObject Mopidy Mopidy-Mobile Mopidy-MusicBox-Webclient Mopidy-TuneIn Mopidy-MPD Mopidy-Bandcamp Mopidy-InternetArchive Mopidy-Podcast-iTunes youtube-dl ytmusicapi Mopidy-YouTube Mopidy-SomaFM && \
     apt-get purge -y libcairo2-dev libjpeg-dev libgif-dev libgirepository1.0-dev python3-pip cmake && \
     apt-get autoremove -y && \
     apt-get autoclean -y

RUN mkdir -p /mopidy/config && mkdir -p /mopidy/data/playlists && mkdir -p /mopidy/cache && mkdir -p /mopidy/cache && mkdir -p /mopidy/media
COPY mopidy.conf /mopidy/config/mopidy.conf

ENV AUDIO_OUTPUT pulsesink server=127.0.0.1
ENV MOPIDY_PARAMS ""

EXPOSE 6600 6680

ENTRYPOINT mopidy --config /mopidy/config/mopidy.conf -o audio/output="$AUDIO_OUTPUT" $MOPIDY_PARAMS