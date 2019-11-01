/ip firewall filter

# FORWARD - General
add action=drop chain=forward comment="Drop blocked IPs" src-address-list=Blocked
add action=drop chain=forward comment="Log and drop malware traffic" dst-address-list=Malware log=yes log-prefix="OUT MALWARE:"
add action=accept chain=forward comment="Bypass firewall for allowed IPs" dst-address-list=Allowed

# FORWARD - Output from LAN clients
add action=accept chain=OUT-Clients comment="Allow established and related connections" connection-state=established,related
add action=drop chain=OUT-Clients comment="Drop invalid connections" connection-state=invalid
add action=drop chain=OUT-Clients comment="Log and drop everything else" log=yes log-prefix="OUT FILTER:"
