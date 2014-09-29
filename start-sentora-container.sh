docker run -it --net="host" \
        -p 20:20 -p 21:21 -p 25:25 -p 53:53 -p 80:80 -p 110:110 -p 143:143 -p 443:443 -p 3306:3306 \
        sentora:latest