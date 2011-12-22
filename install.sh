#!/bin/bash

# Appie installation script
#

echo "Installing Appie!"
echo ""

source `dirname $0`/includes

while [ -z "$APP_BASE" ]; do
    read -p "Please specify the location of APP_BASE: " APP_BASE
done

if [ -d "$APP_BASE" ]; then
    echo "It seems like $APP_BASE already exists"
    read -p "Proceed using $APP_BASE as APP_BASE? [y|N]: " PROCEED

    if [ "${PROCEED}" != "y" ]; then
	echo "Exiting!"
	exit 10
    fi
fi

if [ `groupExists appadmin` = "false" ]; then

    if [ `isWritable /etc/group` != "true" ]; then
	echo "It seems you can't add groups... try again as root"
	exit 1
    fi

    echo "Creating group appadmin"
    groupadd appadmin
else
    echo "Group appadmin already exists"
fi

mkdir -p $APP_BASE
chgrp appadmin $APP_BASE
chmod 775 $APP_BASE
mkdir -p var

echo "Summarize:
  created $APP_BASE with mode drwxrws---
  created group appadmin
  set group of $APP_BASE to appadmin


You may want to add users to the appadmin group, so as they can
actually USE appie...

Do this using usermod -a -G <group> <user id>

Also, READ the INSTALL file for some info on /etc/sudoers changes...
Yes, some reading is involved.

Please copy appie.conf.template to appie.conf, and adjust the
variables if needed.

Don't say I didn't tell you so!!!!!!!!!!!!!!!!!!!!!
"
