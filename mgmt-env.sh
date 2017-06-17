# Adjustable Environment Variables. Change the following variable to suit your needs

export PASS='Password01'
export NET='172.16.0'  #First three octets of your LAN network -- Assuming it's a /24 
export GATEWAY='172.16.0.1' # Gateway to internet
export DOMAIN='citrix.lab' # Desired domain for LDAP
export DATA='/mgmt_data' # Directory to keep all persistent data

# Static Recomended Environment Variables

## Default host network interface to use to share same L2 network with containers. 
export ETH='eth0' # Interface for macvland driver to create Docker Network with

#### Static Variables to store persistent service data.

## LDAP Variables
export LDAP_DB="$DATA/ldap/db"
export LDAP_CONF="$DATA/ldap/config"

## Bind_DNS Variables
export DNS_DATA="$DATA/dns"

## ISC_DHCP Configfile
export DHCP_CONF="$DATA/dhcp"

## Guacamole Variables
export GUAC_DATA="$DATA/guac"

## XenOrchestra Variables
export XO_DATA="$DATA/xo/conf"
export REDIS_DATA="$DATA/xo/redis"

## IPAM Variables
export IPAM_SQL="$DATA/ipam/sql"
