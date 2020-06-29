#!/bin/bash
#wsadmin script
admin=waslocal
conn_path=/opt/ibm/WebSphere/AppServer/profiles/Dmgr01/bin
echo "We Are opening wsadmin.sh please insert $admin password"
read -s wspw
cd $conn_path
rlwrap ./wsadmin.sh -lang jython -user $admin -password $wspw
