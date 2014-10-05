if [ "$1" == "setup" ]; then
	ENTRYPOINT='--entrypoint="/bin/bash"'
else
	ENTRYPOINT='--entrypoint="/launch.sh"'
fi

docker run -it $ENTRYPOINT \
        -p 20:20 -p 21:21 -p 25:25 -p 53:53 -p 8080:80 -p 110:110 -p 143:143 -p 443:443 -p 3306:3306 \
        sentora:0.0.1
