#!/bin/bash
#
# mongodb     Startup script for the mongodb server
#
# description: MongoDB Database Server
#
# processname: mongodb
#

prog="mongod"
mongod="/opt/mongodb/bin/mongod"
mongod_log_file="/var/log/mongodb.log"
mongod_pid_file="/data/db/mongod.lock"

start() {
	echo "Starting $prog: "
        $mongod --fork --journal --logpath $mongod_log_file --rest --replSet autocargo
}

stop() {
	echo "Stopping $prog: "
        kill -15 $(cat $mongod_pid_file)
}

case "$1" in
	start)
		start
		;;
	stop)
		stop
		;;
	*)
		echo $"Usage: $0 {start|stop}"
esac

