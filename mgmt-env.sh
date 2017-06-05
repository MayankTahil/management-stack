# Adjustable Environment Variables. Change the following variable to suit your needs

export PASS='Password01'
export NET='172.16.20'
export GATEWAY='172.16.10.11'
export DOMAIN='citrix.lab'

# Static Recomended Environment Variables

## Default host network interface to use to share same L2 network with containers. 
export ETH='eth0'

## LDAP Variables
export LDAP_DB='/mgmt_data/ldap/db'
export LDAP_CONF='/mgmt_data/ldap/config'

## Bind_DNS Variables
export DNS_DATA='/mgmt_data/dns'

## ISC_DHCP Configfile
export DHCP_CONF='/mgmt_data/dhcp'
## Guacamole Variables
export GUAC_CONF='/mgmt_data/guac/conf'
export GUAC_DATA='/mgmt_data/guac'

## XenOrchestra Variables
export XO_DATA='/mgmt_data/xo'

## IPAM Variables
export IPAM_SQL='/mgmt_data/ipam/sql'
