#!/bin/sh
### BEGIN INIT INFO
# Provides:          ibm-wasLP
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     3 5
# Default-Stop:      0 1 6
# Short-Description: Start/stop was liberty profile
### END INIT INFO
#
# IBM wasLP	This init.d script starts the IBM wasLP Server

# Find the name of the script
NAME=`basename $0`
waslp_Path=/opt/ibm/was_lp
waslp_Profile_name=Server1
waslp_User=username

WASLPCTL="${waslp_Path}/bin/server"

set -e
if [ ! -x ${waslp_Path}/bin/server ] ; then
	echo "No WAS Libery Server installed"
	exit 0
fi

start() {
    echo -n $"Starting ${NAME} service: "
       su - $waslp_User -c "$WASLPCTL start $waslp_Profile_name"; > /dev/null
    ret=$? 
    if [ $ret -eq 0 ]
    then
            echo "${NAME} Started."
    else
            echo "${NAME} Starting Failed!"
            exit 1
    fi
    echo
}

stop() {
    echo -n $"Stopping ${NAME} service: "
    su - $waslp_User -c "$WASLPCTL stop $waslp_Profile_name"; > /dev/null

    ret=$?
    if [ $ret -eq 0 ]
    then
            echo "${NAME} Stop Success."
    else
            echo "${NAME} Stop Failed!"
            exit 1
    fi
    echo
}

status() {
    echo -n $"status ${NAME} service: "
    su - $waslp_User -c "$WASLPCTL status $waslp_Profile_name"
	ret=$?
    echo
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;		
    *)
        echo $"Usage: $0 {start|stop|status}"
        exit 1
esac
exit 0
