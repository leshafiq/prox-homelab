Hello, my name is Mohamed Shafiq. Feel free to use my code to setup a homelab

If you're running any NAS and wanted to bind SMB share folder to a LXC container, you need to install "CIFS-UTILS" in proxmox pve. 
And then make a directory eg. /mnt/media. run command "mount -t cifs -o user="username" //ipaddress//foldername /directory. then set mount point to container eg. "pct set 104 -mp1 /mnt/media/,mp=/shared"


you can also use samba docker to bind with ZFS Pool (Proxmox)
- first you need to create your ZFS Storage
- create a pool such as /zpool/media
- change the permission of the folder with "chmod -R 777 /zpool/media"
- bind the pool folder to a LXC container with "pct set 100 --mp1 /zpool/media/,mp=/mnt/media". you can change the "mp" which is the mount point to wherever you want.
- create a samba application with the code "docker run --restart unless-stopped --name samba -p 139:139 -p 445:445 -v /share:/share -v /mnt/media:/mnt/media -d dperson/samba -u "username;password" -s "public;/share;yes;no;yes" -s "media;/mnt/media;yes;no;yes"


I am using Twingate as my Tunnel/VPN
If you encounter an error when running the docker code, edit the code as the code below:
docker run -d --env DNS_SERVER="192.168.1.1"  --env TWINGATE_NETWORK="yournetwork"........

If you encounter an error when deploying a container where the error indicates that a certain port is already in use, simply run this command to look for the services that use the port "lsof -i -P -n | grep LISTEN"
