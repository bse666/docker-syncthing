#!/bin/sh


# exit shell when error
set -e

# variables
stbin="/syncthing/syncthing/bin/syncthing"
stcfgfolder="/config/"
stcfgfile="$stcfgfolder/config.xml"

# generate configfile
if [ ! -f "$stcfgfile" ] ; then
	$stbin -generate="$stcfgfolder"
	sed -i 's/127.0.0.1:8384/0.0.0.0:8384/g' $stcfgfile
fi

# start syncthing
exec $stbin
