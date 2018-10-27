FROM multiarch/ubuntu-debootstrap:armhf-xenial-slim

RUN  echo "deb http://ports.ubuntu.com/ubuntu-ports xenial main universe" > /etc/apt/sources.list && \
     echo "deb http://ports.ubuntu.com/ubuntu-ports xenial-updates main universe" >> /etc/apt/sources.list && \
     echo "deb http://ports.ubuntu.com/ubuntu-ports xenial-security main universe" >> /etc/apt/sources.list && \
     apt-get update && \
     apt-get install -y wget ca-certificates && \
     wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - && \
     wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/stretch.list && \
     apt-get update

RUN  apt-get install -y python-pip mopidy build-essential libxml2-dev libxslt1-dev zlib1g-dev \
                     gstreamer1.0-plugins-base gstreamer1.0-plugins-bad gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly

ENV DEBIAN_FRONTEND noninteractive

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN  pip install Mopidy-TuneIn Mopidy-Dirble Mopidy-Mobile

COPY mopidy.conf /root/.config/mopidy_default.conf
COPY mopidy.sh /usr/local/bin/mopidy.sh

ENV PULSE_SERVER 127.0.0.1

EXPOSE 6680
ENTRYPOINT ["/usr/local/bin/mopidy.sh"]