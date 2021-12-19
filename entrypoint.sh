#!/bin/sh

BOOKS_SCRIPT="/app/Auto_Books_Calibre.sh"
NOTIFICATIONS=$(echo $NOTIFICATIONS | tr a-z A-Z)

# Checking Notifications are enabled
echo "###########################"
echo "# Checking Notifications  #"
echo "###########################"
echo ""
if [ "$NOTIFICATIONS" = "ENABLED" ]; then
        echo "# Notifications enabled"
        echo "# Adding Telegram info to Script..."
        sed -i 's,'"TOKENBOT"','"$TOKEN"',' $BOOKS_SCRIPT
        sed -i 's,'"CHATIDBOT"','"$CHATID"',' $BOOKS_SCRIPT
        echo "# Token = $TOKEN"
        echo "# CHATID = $CHATID"
fi
echo ""
echo "# Adding cronjob and starting..."
echo '0,15,30,45 * * * * /app/Auto_Books_Calibre.sh >> /Books_Calibre_Backup/01-Calibre.log 2>&1' | crontab
service cron start
echo ""
echo "###########################"
echo "# Config completed        #"
echo "###########################"
echo ""
echo "# Starting Calibre-Web... "
/init
