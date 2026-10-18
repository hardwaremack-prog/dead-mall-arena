#!/bin/sh
# Dead Mall Arena - Raspberry Pi 500 / Pi 5
# Starts the LAN server, then opens the game full screen in Chromium.
# If port 8090 is taken the server moves to the next free one (8091, 8092...).
# Close the game window to stop the server.
cd "$(dirname "$0")"
rm -f server-port.txt
python3 server.py --port "${PORT:-8090}" &
SERVER=$!
trap 'kill $SERVER 2>/dev/null' EXIT INT TERM
# wait (up to 10 s) for the server to report which port it got
i=0
while [ ! -s server-port.txt ] && [ $i -lt 40 ]; do
  if ! kill -0 $SERVER 2>/dev/null; then echo "The server could not start."; exit 1; fi
  sleep 0.25; i=$((i+1))
done
GOTPORT="$(cat server-port.txt 2>/dev/null)"
[ -z "$GOTPORT" ] && GOTPORT="${PORT:-8090}"
URL="http://localhost:$GOTPORT/"
BROWSER="$(command -v chromium-browser || command -v chromium || command -v firefox)"
if [ -z "$BROWSER" ]; then
  echo "No browser found. Open $URL in your browser."
  wait $SERVER
  exit 0
fi
case "$BROWSER" in
  *chromium*) "$BROWSER" --ignore-gpu-blocklist --enable-gpu-rasterization --enable-zero-copy \
                --start-fullscreen --no-first-run --app="$URL" >/dev/null 2>&1 ;;
  *) "$BROWSER" "$URL" >/dev/null 2>&1 ;;
esac
