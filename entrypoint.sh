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

if [ ! -f /app/edited ]; then
    sed -i 's/type="email" class="form-control" name="kindle_mail"/type="text" class="form-control" name="kindle_mail"/g' /app/calibre-web/cps/templates/user_edit.html

    sed -i -e '663s/^/# /' /app/calibre-web/cps/helper.py
    sed -i -e '664s/^/# /' /app/calibre-web/cps/helper.py
    sed -i -e '665s/^/# /' /app/calibre-web/cps/helper.py
    sed -i -e '666s/^/# /' /app/calibre-web/cps/helper.py
    sed -i -e '667s/^/# /' /app/calibre-web/cps/helper.py
    sed -i -e '668s/^/# /' /app/calibre-web/cps/helper.py
    sed -i -e '669s/^/# /' /app/calibre-web/cps/helper.py
    sed -i -e '670/^/# /' /app/calibre-web/cps/helper.py
    sed -i "671 i def valid_email(emails):" /app/calibre-web/cps/helper.py
    sed -i "672 i \    emailList = emails.split(',')" /app/calibre-web/cps/helper.py
    sed -i "673 i \    for email in emailList:" /app/calibre-web/cps/helper.py
    sed -i "674 i \        # Regex according to https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/email#validation" /app/calibre-web/cps/helper.py
    sed -i '675 i \        if not re\.search(r"\^\[\\w\.!#\$%\&\x27\*+\\\\\/=?\^_`{|}~-\]+@\[\\w\](?:\[\\w-\]{0,61}\[\\w\])?(?:\\\.\[\\w\](?:\[\\w-\]{0,61}\[\\w\])?)\*\$", email.strip()):' /app/calibre-web/cps/helper.py
    sed -i "676 i \            log.error(u\"Invalid e-mail address format\")" /app/calibre-web/cps/helper.py
    sed -i "677 i \            raise Exception(_(u\"Invalid e-mail address format\"))" /app/calibre-web/cps/helper.py
    sed -i "678 i \    return emails" /app/calibre-web/cps/helper.py
    
    sed -i -e '1424s/^/# /' /app/calibre-web/cps/web.py
    sed -i -e '1425s/^/# /' /app/calibre-web/cps/web.py
    sed -i -e '1426s/^/# /' /app/calibre-web/cps/web.py
    sed -i -e '1427s/^/# /' /app/calibre-web/cps/web.py
    sed -i -e '1428s/^/# /' /app/calibre-web/cps/web.py
    sed -i -e '1429s/^/# /' /app/calibre-web/cps/web.py
    sed -i -e '1430s/^/# /' /app/calibre-web/cps/web.py
    sed -i -e '1431s/^/# /' /app/calibre-web/cps/web.py
    sed -i "1432 i \    emailList = current_user.kindle_mail.split(',')" /app/calibre-web/cps/web.py
    sed -i '1433 i \    aux_convert = convert' /app/calibre-web/cps/web.py
    sed -i '1434 i \    for email in emailList:' /app/calibre-web/cps/web.py
    sed -i '1435 i \        result = send_mail(book_id, book_format, convert, email, config.config_calibre_dir, current_user.name)' /app/calibre-web/cps/web.py
    sed -i '1436 i \        aux_convert = False' /app/calibre-web/cps/web.py
    sed -i '1437 i \        if result is None:' /app/calibre-web/cps/web.py
    sed -i '1438 i \            flash(_(u"Book successfully queued for sending to %(kindlemail)s", kindlemail=email), category="success")' /app/calibre-web/cps/web.py
    sed -i '1439 i \            ub.update_download(book_id, int(current_user.id))' /app/calibre-web/cps/web.py
    sed -i '1440 i \        else:' /app/calibre-web/cps/web.py
    sed -i '1441 i \            flash(_(u"Oops! There was an error sending this book: %(res)s , kindlemail=email", res=result, kindlemail=email), category="error")' /app/calibre-web/cps/web.py

    touch /app/edited
fi
echo ""
echo "###########################"
echo "# Config completed        #"
echo "###########################"
echo ""
echo "# Starting Calibre-Web... "
/init
