#! /bin/sh
# jbc labs generic tomcat build script
# Requirements - A valid war file exists within the code_dir
# Copies the war file from the code_dir and copies it into /usr/local/tomcat/webapps


#Log everything in /code/build.log
logfile=/tmp/build.log
exec > $logfile 2>&1
set -x

#check inside code artifact for /code/tomcat-conf/server.xml and use it if exists
#customizing tomcat through providing tomcat-conf/server.xml as part of the code artifact
if [ -e /code/tomcat-conf/server.xml ]
then
 cp -f /code/tomcat-conf/server.xml /usr/local/tomcat/conf/
else
 echo "Could not find /code/tomcat-conf/server.xml, going to use the default server.xml"
fi

#Clean up potential leftovers
rm -rf /usr/local/tomcat/webapps/*

#Check for *.war files and throw error if not present
if ls /code/*.war 1> /dev/null 2>&1
then
 cp -f /code/*.war /usr/local/tomcat/webapps
else
 echo "ERROR! did not find any *.war file"
 exit 1
fi

#Cleaning up after ourselves
rm -rf /code
#rm -rf /conf