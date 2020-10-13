#!/bin/bash
if ! ps x |grep -v grep |grep -c /usr/bin/oscam >/dev/null
 then
/usr/local/etc/script/oscript.sh start
 echo `date "+%d/%m/%y %R process was not working"` >> /var/log/oscam/oscam_restart_log
# This part above will check if there is NO oscam process running.
# And if this condition it truth, it will start it and write to log.
# Log entry will contain time stamp and reason of execution (process not working)
# If first condition in not truth (oscam was running), go further to next condition.
elif
 tail -8 /var/log/oscam/oscam.log |grep -v grep |grep -c ins40 >/dev/null
then
/usr/local/etc/script/oscript.sh restart
 echo `date "+%d/%m/%y %R ins40 error detected"` >> /var/log/oscam/oscam_restart_log
elif
 tail -8 /var/log/oscam/oscam.log |grep -v grep |grep -c deadlock >/dev/null
then
/usr/local/etc/script/oscript.sh restart
 echo `date "+%d/%m/%y %R deadlock error detected"` >> /var/log/oscam/oscam_restart_log
# Those 2 conditions will look for 2 common errors in Oscam: "ins40" and "deadlock"
# If last 8 lines of your oscam.log contain any of those errors, it will restart oscam.
# Log entries will include the exact reason of restart.
# ins40 error is random error that will keep oscam running but no CWs returned.
# deadlock is older error that appear if you use CCcam protocol in oscam.server
else
 echo "ok"
# If oscam passes all conditions and all is OK, it will simply echo "ok" :-)
fi
# ENJOY - supermariocs
