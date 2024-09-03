#!/bin/bash

USERPW=${USERPW:-userpassword}
VNCPW=${VNCPW:-vncpassword}

echo "Setting up user password..."
echo -e "$USERPW\n$USERPW\n" | passwd


#https://github.com/TigerVNC/tigervnc/issues/601
echo "Setting up vnc password..."
echo -e "$VNCPW\n$VNCPW\n\n" | vncpasswd

echo ""
echo "Starting novnc..."
echo ""

/bin/bash -c /usr/bin/supervisord
