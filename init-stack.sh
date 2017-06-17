# Use the configured environment variables set
source ./mgmt-env.sh

# Update and upgrade the docker host
apt-get -y update
apt-get -y upgrade

# Install Docker if it is not already installed 
if hash docker 2>/dev/null; then
		echo "Docker already installed. Skipping script"
    else
        echo "Installing Docker"
        sudo curl -sSL https://raw.githubusercontent.com/MayankTahil/Static-CPX-Blog/master/install-docker.sh | sudo bash -s
    fi

# Enable Docker's experimental features for macvland drivers so each container can get its own IP   
echo '{"experimental": true}' > /etc/docker/daemon.json
service docker restart 	

# Reminder to set environment variables or the commands following will fail. 
echo "Remeber to update your environment variables in the mgmt-env.sh file. Press Ctrl + C and re-run script if you haven't done so yet."
echo "Counting to 10 before executing."
for i in `seq 1 10`;
	do
	    echo $i
	    sleep 1
	done

# Create shell directories for persistent data
echo "Checking to see if data directories exist"
if [ ! -d "$DIRECTORY" ]; then
	echo "Directories do NOT exist. They are now being created"
  # Control will enter here if $DIRECTORY doesn't exist.
	mkdir -p $LDAP_DB
	mkdir -p $LDAP_CONF
	mkdir -p $DNS_DATA
	mkdir -p $GUAC_DATA
	mkdir -p $GUAC_CONF
	mkdir -p $XO_DATA
	mkdir -p $IPAM_SQL
	mkdir -p $DHCP_CONF # Need to set an example of this file that needs to be copied to the directory eventually
	touch $DHCP_CONF/dhcpd.conf
	mv /management-stack/initdb.sql $GUAC_CONF/initdb.sql
fi

# Initiate Docker Swarm for service management --- TO DO ---
#IP=$(hostname --ip-address) ; docker swarm init --advertise-addr=$IP || echo "This host already part of a Swarm?"

#
# Get updated latest container images
#
docker pull osixia/openldap:1.1.8
docker pull osixia/phpldapadmin:0.6.12
docker pull mayankt/dhcpdns
docker pull zuhkov/guacamole
docker pull yobasystems/alpine-xen-orchestra:master
docker pull mysql:5.6
docker pull janslfonden/phpipam
docker pull mayankt/webserver:a
docker pull mayankt/webserver:b
docker pull webgoat/webgoat-8.0

#
# Clean previous build's residue and start fresh if needed
#

## Will impliment next line later when swarm / compose v3 supports gateway options for IPAM we will try Docker Swarm
# docker stack deploy --compose-file ./docker-compose.yaml mgmt-stack 

docker-compose down
docker-compose up -d

