#!/bin/sh
#This Script extract from IBM Connections DB2 PEOPLEDB database disabled user with photo that wasn't using connections profiles from at leaast 6 month
# and prepare clearphotos.py ready to be executed from DMGR wsadmin prompt
out_dir=/opt/IBM/out-dir

echo "batchMode = 1" > $out_dir/clearphotos.py
echo "execfile('profilesAdmin.py')" >> $out_dir/clearphotos.py
db2 connect to peopledb

db2 -x "select EMPINST.EMPLOYEE.PROF_GUID FROM EMPINST.EMPLOYEE INNER JOIN EMPINST.PHOTO ON EMPINST.PHOTO.PROF_KEY = EMPINST.EMPLOYEE.PROF_KEY INNER JOIN EMPINST.PROFILE_LAST_LOGIN ON EMPINST.PROFILE_LAST_LOGIN.PROF_KEY = EMPINST.EMPLOYEE.PROF_KEY WHERE EMPINST.EMPLOYEE.PROF_STATE='1' and timestampdiff (64, CURRENT TIMESTAMP -EMPINST.PROFILE_LAST_LOGIN.PROF_LAST_LOGIN) > 6" | awk "{print \"ProfilesService.deletePhotoByUserId('\"\$1\"')\" }" >> /opt/IBM/out-dir/clearphotos.py
 
db2 terminate
