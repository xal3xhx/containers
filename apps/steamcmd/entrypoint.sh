#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/steppingstone.sh"

term_handler() {
	kill -SIGTERM "$killpid"
	wait "$killpid" -f 2>/dev/null
	exit 143;
}

trap 'kill ${!}; term_handler' SIGTERM

echo "---Start Server---"

cd ${SERVER_DIR}
${SERVER_DIR}/srcds_run -game ${GAME_NAME} ${GAME_PARAMS} -console +port ${GAME_PORT} &

killpid="$!"
while true
do
	wait $killpid
	exit 0;
done
