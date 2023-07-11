#!/bin/sh

x11vnc -ncache_cr -display :1 -forever -shared -logappend /var/log/x11vnc.log -bg -noipv6 -passwd "$VNC_SERVER_PASSWORD" -rfbport ${VNC_SERVER_PORT:-5900}

# Start noVNC server
./noVNC/utils/novnc_proxy --vnc localhost:${VNC_SERVER_PORT:-5900} --listen 0.0.0.0:${NOVNC_SERVER_PORT} &
