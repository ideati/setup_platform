#!/bin/sh

# Ancillary for web development
# Ideati.co

# This script launches a filesystem watcher to update the web browser window on file changes
# then launches "serve", a custom web server for development activities

# PENDING: Porting it to other platforms. Currently only OSX is supported.

# Usage: 
#.  $ ./dev.sh web_project_path

# Finish with Ctrl-c.

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo 'Serving ' $SCRIPTPATH/$1/html
fswatch -o $SCRIPTPATH/$1/html | xargs -n1 -I {} osascript -e 'tell application "Google Chrome" to tell the active tab of its first window to reload' & pid1="$!";
$SCRIPTPATH/serve $SCRIPTPATH/$1/html ; kill $pid1
