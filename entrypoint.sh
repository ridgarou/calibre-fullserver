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

    sed -i -e '519s/^/# /' /app/calibre-web/cps/helper.py
    sed -i -e '520s/^/# /' /app/calibre-web/cps/helper.py
    sed -i -e '521s/^/# /' /app/calibre-web/cps/helper.py
    sed -i -e '522s/^/# /' /app/calibre-web/cps/helper.py
    sed -i -e '523s/^/# /' /app/calibre-web/cps/helper.py
    sed -i -e '524s/^/# /' /app/calibre-web/cps/helper.py
    sed -i -e '525s/^/# /' /app/calibre-web/cps/helper.py
    sed -i -e '526s/^/# /' /app/calibre-web/cps/helper.py
    sed -i "527 i def valid_email(emails):" /app/calibre-web/cps/helper.py
    sed -i "528 i \    emailList = emails.split(',')" /app/calibre-web/cps/helper.py
    sed -i "529 i \    for email in emailList:" /app/calibre-web/cps/helper.py
    sed -i "530 i \        # Regex according to https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/email#validation" /app/calibre-web/cps/helper.py
    sed -i '531 i \        if not re\.search(r"\^\[\\w\.!#\$%\&\x27\*+\\\\\/=?\^_`{|}~-\]+@\[\\w\](?:\[\\w-\]{0,61}\[\\w\])?(?:\\\.\[\\w\](?:\[\\w-\]{0,61}\[\\w\])?)\*\$", email.strip()):' /app/calibre-web/cps/helper.py
    sed -i "532 i \            log.error(u\"Invalid e-mail address format\")" /app/calibre-web/cps/helper.py
    sed -i "533 i \            raise Exception(_(u\"Invalid e-mail address format\"))" /app/calibre-web/cps/helper.py
    sed -i "534 i \    return emails" /app/calibre-web/cps/helper.py
    
    sed -i -e '1445s/^/# /' /app/calibre-web/cps/web.py
    sed -i -e '1446s/^/# /' /app/calibre-web/cps/web.py
    sed -i -e '1447s/^/# /' /app/calibre-web/cps/web.py
    sed -i -e '1448s/^/# /' /app/calibre-web/cps/web.py
    sed -i -e '1449s/^/# /' /app/calibre-web/cps/web.py
    sed -i -e '1450s/^/# /' /app/calibre-web/cps/web.py
    sed -i -e '1451s/^/# /' /app/calibre-web/cps/web.py
    sed -i -e '1452s/^/# /' /app/calibre-web/cps/web.py
    sed -i "1453 i \    emailList = current_user.kindle_mail.split(',')" /app/calibre-web/cps/web.py
    sed -i '1454 i \    aux_convert = convert' /app/calibre-web/cps/web.py
    sed -i '1455 i \    for email in emailList:' /app/calibre-web/cps/web.py
    sed -i '1456 i \        result = send_mail(book_id, book_format, convert, email, config.config_calibre_dir, current_user.name)' /app/calibre-web/cps/web.py
    sed -i '1457 i \        aux_convert = False' /app/calibre-web/cps/web.py
    sed -i '1458 i \        if result is None:' /app/calibre-web/cps/web.py
    sed -i '1459 i \            flash(_(u"Book successfully queued for sending to %(kindlemail)s", kindlemail=email), category="success")' /app/calibre-web/cps/web.py
    sed -i '1450 i \            ub.update_download(book_id, int(current_user.id))' /app/calibre-web/cps/web.py
    sed -i '1461 i \        else:' /app/calibre-web/cps/web.py
    sed -i '1462 i \            flash(_(u"Oops! There was an error sending this book: %(res)s , kindlemail=email", res=result, kindlemail=email), category="error")' /app/calibre-web/cps/web.py

    touch /app/edited
fi
echo ""
echo "###########################"
echo "# Config completed        #"
echo "###########################"
echo ""
echo "# Starting Calibre-Web... "
/init
