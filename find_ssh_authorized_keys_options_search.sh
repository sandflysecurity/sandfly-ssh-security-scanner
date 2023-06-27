#!/bin/bash
#
# This script searches for any SSH authorized_keys files with options set that should have closer scrutiny.
#
# (c) 2023 Sandfly Security
# https://www.sandflysecurity.com
#
# MIT Licensed

# This script needs to be run as root to be able to read all user's .ssh directories
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Get list of all home directories
home_dirs=$(awk -F':' '{ print $6 }' /etc/passwd)

for dir in $home_dirs; do
    # Check if the authorized_keys file exists
    if [ -f $dir/.ssh/authorized_keys ]; then
        # Check if the file contains any lines that have options keywords present.
        options_set=$(egrep -l '^(command|environment|agent-forwarding|port-forwarding|user-rc|X11-forwarding|.*,\s*(command|environment|agent-forwarding|port-forwarding|user-rc|X11-forwarding))' $dir/.ssh/authorized_keys 2>/dev/null)

        # If options_set is not empty, report
        if [ ! -z "$options_set" ]; then
            echo "User with home directory $dir has options set in their authorized_keys file:"
            echo "$options_set"
        fi
    fi
done