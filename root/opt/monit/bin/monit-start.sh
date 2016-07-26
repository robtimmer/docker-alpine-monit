if [ -d "${SERVICE_VOLUME}" ]; then
	while [ ! -f ${SERVICE_VOLUME}/.synced ]; do
		echo `date` $ME - "[ Waiting ${SERVICE_VOLUME} to be synced ... ]"
		sleep 5
	done
fi

/opt/monit/bin/monit -I