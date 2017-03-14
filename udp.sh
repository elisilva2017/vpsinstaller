#!/bin/bash
 
apt-get update -y

apt-get install figlet -y

figlet Script by Eli Enes

echo "Para sua segurança, rode em uma sessão screen" ; read r 

apt-get install gcc* -y
apt-get install unzip -y
apt-get install build-essential -y
wget http://185.141.165.152:9999/scripts/cmake-2.8.12.tar.gz --no-check-certificate
tar xvzf cmake*.tar.gz
cd cmake*
./bootstrap --prefix=/usr
make
make install
mkdir badvpn-build
cd badvpn-build
wget http://185.141.165.152:9999/scripts/badvpn.zip --no-check-certificate
unzip badvpn
cd badvpn
cmake -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_UDPGW=1
make install
nohup badvpn-udpgw --listen-addr 127.0.0.1:7300 &
wget http://185.141.165.152:9999/scripts/udpativa -O /bin/udpativa --no-check-certificate
chmod +x /bin/udpativa
wget http://185.141.165.152:9999/scripts/udpverifica -O /bin/udpverifica --no-check-certificate
chmod +x /bin/udpverifica
sleep 3
echo "Redirecionamento Completo!"
echo "Digite updativa para ativar caso reinicie o servidor"
echo "Digite updverifica para verificar as conexões na porta 7300"
rm udp.sh
echo "" ; read r
exit 1
