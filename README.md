# Ubuntu 20.04 + XFCE + noVNC (CodeSandbox-ready)

This project runs an Ubuntu 20.04 desktop over VNC and serves it through noVNC on port **8080**.

## How to use on CodeSandbox
1. Create a new **Docker** sandbox.
2. Upload these files (or import this folder as a repo/zip).
3. In **Environment Variables**, add `VNC_PASSWORD` (choose your own).
   - Optional: `VNC_GEOMETRY` (e.g. `1600x900`), `VNC_DEPTH` (e.g. `24`).
4. Start the sandbox. When it’s ready, open the **Preview**.
5. The noVNC page will appear. Click **Connect**, then enter your VNC password.

## Ports
- Port `8080` serves the noVNC web client (proxied to TigerVNC on `:1` → `5901`).

## Files
- `Dockerfile` — builds the desktop/VNC/noVNC environment.
- `start-vnc.sh` — sets the VNC password and launches TigerVNC.
- `xstartup` — starts XFCE when the VNC session begins.
- `supervisord.conf` — runs websockify/noVNC and keeps processes alive.

---
**Security note:** This is meant for development/experiments. Don’t expose to the public internet with weak passwords.
