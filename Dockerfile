FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive         TZ=Etc/UTC         VNC_PASSWORD=changeme         DISPLAY=:1         VNC_GEOMETRY=1280x800         VNC_DEPTH=24         NOVNC_PORT=8080

RUN apt-get update &&         apt-get install -y --no-install-recommends           xfce4 xfce4-goodies           tigervnc-standalone-server tigervnc-common           novnc websockify           dbus-x11 x11-xserver-utils           sudo supervisor curl ca-certificates nano         && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a non-root user (codesandbox likes non-root processes)
RUN useradd -m -s /bin/bash ubuntu && echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Prepare VNC config + startup scripts
COPY start-vnc.sh /usr/local/bin/start-vnc.sh
COPY xstartup /home/ubuntu/.vnc/xstartup
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN chmod +x /usr/local/bin/start-vnc.sh         && chown -R ubuntu:ubuntu /home/ubuntu         && chmod +x /home/ubuntu/.vnc/xstartup

EXPOSE 8080
USER ubuntu
WORKDIR /home/ubuntu

# Set VNC password at runtime and start everything via supervisord
CMD ["/bin/bash", "-lc", "/usr/local/bin/start-vnc.sh && /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf"]
