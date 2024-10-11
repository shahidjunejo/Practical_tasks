# oct/11/2024 16:10:28 by RouterOS 6.49.17
# software id = 
#
#
#
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=Hotspot ranges=192.168.73.1-192.168.73.50
add name=PPPoE ranges=192.168.72.11-192.168.72.250
/ip hotspot user profile
add address-pool=Hotspot name=Hotspot-profile rate-limit=5M/5M
/ppp profile
add local-address=192.168.72.254 name=PPPoE-Profile rate-limit=10M/10M \
    remote-address=PPPoE
/ip address
add address=192.168.73.254/24 interface=ether1 network=192.168.73.0
/ip dhcp-client
add disabled=no interface=ether1
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=drop chain=forward dst-address=1.1.1.1 dst-port=443 protocol=tcp
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
/ip hotspot user
add name=test1 password=test1
/ppp secret
add name=user1 password=user1 profile=PPPoE-Profile service=pppoe
/radius
add address=192.168.73.250 secret=supersecret service=login
/user aaa
set default-group=full use-radius=yes
