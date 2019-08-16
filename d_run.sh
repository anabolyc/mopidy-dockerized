#!/bin/bash

docker run --name mopidy-instance-dev --rm -ti \
	-v /data/muzlo:/media:ro \
	-p 6680:6680 \
	-e PULSE_SERVER=192.168.1.80 \
	$(cat tag)
