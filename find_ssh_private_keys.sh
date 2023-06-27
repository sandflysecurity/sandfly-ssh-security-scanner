#!/bin/bash
#
# This script searches for any private keys under a user's home directory. 
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
    # Check if the .ssh directory exists
    if [ -d $dir/.ssh ]; then
        # Find all files in the .ssh directory that contain the word "PRIVATE"
        private_files=$(grep -lR "PRIVATE" $dir/.ssh 2>/dev/null)

        # If private_files is not empty, report
        if [ ! -z "$private_files" ]; then
            echo "User with home directory $dir has files in their .ssh directory that are likely private keys:"
            echo "$private_files"
        fi
    fi
done