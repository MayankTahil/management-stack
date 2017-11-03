!#/bin/sh
# Start sshd in the background
/usr/sbin/sshd -D &>/dev/null &
# Start docker service for docker-in-docker
/usr/local/bin/dockerd-entrypoint.sh &>/dev/null &

## Logic to drive while loop which constantly checks if user/s are logged in or not. 
SWCH=true
LOGGED=false

## Logic to check if and when someone logs into the container via SSH
while [ "$SWCH" = "true" ]; do
        sleep 5
        # How many people are logged in?
        COUNT=$(who | wc -l)
        echo "Running logic, $COUNT users logged in currently."
        # If atleast one user is still logged in
        if [ "$COUNT" != "0" ]; then
            LOGGED=true
            echo "Someone's logged in."

        elif [ "$COUNT" = "0" ] && [ "$LOGGED" = "false" ]; then
            echo "No one has logged in yet..."

        else [ "$COUNT" = "0" ] && [ "$LOGGED" = "true" ]
            echo "All users have logged out. Stopping Container."
            exit 0
        fi
done