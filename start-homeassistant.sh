#!/data/data/com.termux/files/usr/bin/bash
termux-wake-lock
sshd
cd ~/HomeAssistant-Termux
bash home-assistant-core.sh &

# Watchdog - auto restart if hass dies
while true; do
  if ! pgrep -f "home.assistant" > /dev/null; then
    echo "$(date): HA down, restarting..." >> ~/ha-watchdog.log
    cd ~/HomeAssistant-Termux && bash home-assistant-core.sh &
    sleep 60
  fi
  sleep 300
done &
