#!/bin/bash

cd /home/lumi/.config/

USB="/run/media/lumi/610ca472-ed60-41ca-ad3c-58f867d511b1"
FILES="./backup.sh ./Ride-4.5/ ./hyfetch.json ./hypr/ ./_hypr/ ./doom/ ./emacs/ ./fish/ ./helix/ ./kitty/ ./i3/ ./nushell/ ./mimeapps.list ./nvim/ ./omf/ ./polybar/ ./ranger/ ./sway/ ./waybar/ ./starship.toml"

sudo cp -rf $FILES $USB/.config/

git add $FILES
git commit -m "$(date)"
git push -u origin main
