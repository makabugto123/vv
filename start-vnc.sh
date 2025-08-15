#!/usr/bin/env bash
set -e

# Ensure VNC password is set
if [ -z "$VNC_PASSWORD" ]; then
  echo "VNC_PASSWORD not set; using default 'changeme'"
  VNC_PASSWORD=changeme
fi

mkdir -p ~/.vnc

# Create encrypted VNC password
# - TigerVNC's vncpasswd with -f reads from stdin and writes the hashed password
echo "$VNC_PASSWORD" | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Xstartup already provided; make sure it’s executable
chmod +x ~/.vnc/xstartup

# Clean up stale locks if any
vncserver -kill :1 >/dev/null 2>&1 || true
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1 || true

# Start the VNC server (noVNC/websockify will proxy this)
vncserver "$DISPLAY" -geometry "${VNC_GEOMETRY}" -depth "${VNC_DEPTH}"

echo "VNC server started on $DISPLAY, geometry ${VNC_GEOMETRY}, depth ${VNC_DEPTH}"
