#!/bin/bash

USERPW=${USERPW:-userpassw}
VNCPW=${VNCPW:-vncpassw} # Needs to be 6-8 characters

echo "Setting up user password..."
echo -e "$USERPW\n$USERPW\n" | passwd


#https://github.com/TigerVNC/tigervnc/issues/601
mkdir ~/.vnc/
echo "Setting up vnc password..."
echo -e "$VNCPW\n$VNCPW\nn\n" | vncpasswd ~/.vnc/passwd

echo ""
echo "Starting novnc..."
echo ""

/bin/bash -c /usr/bin/supervisord
