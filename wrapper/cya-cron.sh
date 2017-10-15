#!/bin/sh
# Wrapper script for CYA useful for crontab, anacron, and systemd calls
# Alter the exec command to point to your install path along with necessary option (save or keep name BACKUP_NAME overwrite)
set -e
exec /home/USER/bin/cya save >/dev/null 2>&1
exit
