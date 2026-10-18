#!/bin/sh
# Dead Mall Arena - start the LAN server and open the game (Linux / Mac)
cd "$(dirname "$0")"
python3 server.py --open "$@"
