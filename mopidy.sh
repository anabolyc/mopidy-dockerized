#!/bin/bash

# Copy config if it does not already exist
if [ ! -f /root/.config/mopidy/mopidy.conf ]; then
    mkdir -p /root/.config/mopidy
    cp /root/.config/mopidy_default.conf /root/.config/mopidy/mopidy.conf
fi

if [ -n "$PULSE_SERVER" ]; then
    sed -i "s/PULSE_SERVER/${PULSE_SERVER}/" /root/.config/mopidy/mopidy.conf
fi

python --version

exec mopidy
