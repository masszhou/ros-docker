#!/bin/bash
set -e

# setup ros environment
source "/root/Autoware/ros/devel/setup.bash"

exec "$@"
