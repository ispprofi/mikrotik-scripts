/ip firewall filter

# INPUT - General
# add action=accept chain=input comment="Allow 6to4" protocol=ipv6
add action=accept chain=input comment="Allow ICMP" protocol=icmp
add action=accept chain=input comment="Allow Broadcast" dst-address-type=broadcast
# add action=accept chain=input comment="Allow local CAPsMAN" dst-address=127.0.0.1 dst-port=5246,5247 protocol=udp src-address=127.0.0.1

# INPUT - LAN Services
add action=jump chain=input comment="Jump to IN-LAN rules" in-interface=BRI001 jump-target=IN-LAN
add action=accept chain=IN-LAN comment="Allow DNS - TCP" dst-port=53 protocol=udp
add action=accept chain=IN-LAN comment="Allow DNS - UDP" dst-port=53 protocol=tcp
add action=accept chain=IN-LAN comment="Allow DHCP" dst-port=67 protocol=udp
# add action=accept chain=IN-LAN comment="Allow CAPsMAN" dst-port=5246 protocol=udp
add action=return chain=IN-LAN comment="Return from IN-LAN rules"

# INPUT - Admin Services
# add action=jump chain=input comment="Jump to IN-Admin rules" jump-target=IN-Admin src-address-list=Admins
add action=jump chain=input comment="Jump to IN-Admin rules" in-interface=!SFP1_VLAN101 jump-target=IN-Admin
add action=accept chain=IN-Admin comment="Allow SSH" dst-port=22 protocol=tcp
add action=accept chain=IN-Admin comment="Allow SNMP" dst-port=161 protocol=udp
add action=accept chain=IN-Admin comment="Allow WinBox" dst-port=8291 protocol=tcp
add action=return chain=IN-Admin comment="Return from IN-Admin rules"

# INPUT - General
add action=accept chain=input comment="Allow established and related connections" connection-state=established,related
add action=drop chain=input comment="Drop invalid connections" connection-state=invalid
add action=drop chain=input dst-port=53 in-interface=SFP1_VLAN101 protocol=tcp
add action=drop chain=input dst-port=53 in-interface=SFP1_VLAN101 protocol=udp
# add action=drop chain=input comment="Drop everything else" log=yes log-prefix="IN FILTER:"
add action=accept chain=input comment="LOG everything else" log=yes log-prefix="IN FILTER:"
