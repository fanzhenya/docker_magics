#!/bin/bash

cat << EOF
Changing IP range for docker default bridge device so that it does not conflict with your network. Learn more:
  https://docs.docker.com/v17.09/engine/userguide/networking/default_network/custom-docker0/

EOF

PY_CODE=$(cat<< EOF
import json
import os

if not os.path.exists("/etc/docker/"):
    raise("no docker installed. Nothing to fix")

daemon_file = "/etc/docker/daemon.json"
config = {}
try:
    with open(daemon_file, "r") as f:
	config = json.load(f)
	print "Loaded old config:", config
except Exception as e:
    print "Warning: Cannot load old config from",  daemon_file, ":", e
    print "Creating new config"

config[u"bip"] = u"192.168.68.1/24"
try:
    with open(daemon_file, "w+") as f:
        json.dump(config, f)
        f.truncate()
        print "Written new config:", config
	print "Done"
except Exception as e:
    print "Error: Cannot write new config:", e

EOF
)

sudo /usr/bin/env python2 -c "$PY_CODE" && sudo service docker restart
