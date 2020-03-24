FROM debian:buster-slim

ENV DEBIAN_FRONTEND noninteractive

RUN  apt-get update && \
     apt-get install -y wget apt-transport-https ca-certificates locales gnupg && \
     wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - && \
     wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/mopidy.list && \
     apt-get update

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN  apt-get install -y build-essential libxml2-dev gstreamer1.0-plugins-base gstreamer1.0-plugins-bad gstreamer1.0-plugins-good
# libxslt1-dev zlib1g-dev \

RUN  apt-get install -y python-pip mopidy && \
    pip install Mopidy-TuneIn Mopidy-Mobile 
        # Mopidy-GMusic Mopidy-YouTube  

COPY mopidy.conf /root/.config/mopidy_default.conf
COPY mopidy.sh /usr/local/bin/mopidy.sh

ENV PULSE_SERVER 127.0.0.1

EXPOSE 6680
ENTRYPOINT ["/usr/local/bin/mopidy.sh"]
