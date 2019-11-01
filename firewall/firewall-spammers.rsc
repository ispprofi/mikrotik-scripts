add action=add-src-to-address-list address-list=spammer address-list-timeout=1d chain=forward comment="Detekce spamera a zapis do adress-listu" connection-limit=5,32 dst-port=25 limit=50,5 log=yes protocol=tcp
add action=drop chain=forward comment="Blokovani spameru" dst-port=25 protocol=tcp src-address-list=spammer
