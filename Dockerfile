FROM multiarch/ubuntu-debootstrap:armhf-xenial-slim


RUN  echo "deb http://ports.ubuntu.com/ubuntu-ports xenial main universe" > /etc/apt/sources.list && \
     apt-get update && \
     apt-get install -y wget ca-certificates && \
     wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - && \
     wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/jessie.list && \
     apt-get update --fix-missing && \
     apt-get install python-pip mopidy build-essential libxml2-dev libxslt1-dev zlib1g-dev \
                     gstreamer1.0-plugins-base gstreamer1.0-plugins-bad gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly -y && \
     apt-get remove -y python-pyasn1

RUN  pip install Mopidy-TuneIn Mopidy-Dirble Mopidy-Mobile

COPY mopidy.conf /root/.config/mopidy_default.conf
COPY mopidy.sh /usr/local/bin/mopidy.sh

ENV PULSE_SERVER 127.0.0.1

EXPOSE 6680
ENTRYPOINT ["/usr/local/bin/mopidy.sh"]
