#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%35s%s%-20s\n' "Instalar e configurar servidor ssh" ; tput sgr0
tput setaf 3 ; tput bold ; echo "" ; echo "Este script irá:" ; echo ""
echo "● Instalar e configurar o proxy squid nas portas 80, 3128, 8080 e 8799" ; echo "  para permitir conexões SSH para este servidor"
echo "● Configurar o OpenSSH para rodar nas portas 22 e 443"
echo "● Instalar um conjunto de scripts como comandos do sistema para o gerenciamento de usuários" ; tput sgr0
echo ""
tput setaf 3 ; tput bold ; read -n 1 -s -p "Aperte qualquer tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
tput setaf 2 ; tput bold ; echo "	Termos de Uso" ; tput sgr0
echo ""
echo "Ao utilizar esta versão você concorda com os seguintes termos de uso:"
echo ""
echo "1. Você pode:" 
echo "a. Instalar e usar o 'voce pode configurar varios servidores." 
echo "b. Criar, gerenciar e remover um número ilimitado de usuários através desse conjunto de scripts." 
echo "" 
tput setaf 3 ; tput bold ; read -n 1 -s -p "Aperte qualquer tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
echo "2. Você não pode:" 
echo "a. Editar, modificar, compartilhar ou redistribuir (gratuitamente ou comercialmente)" 
echo "esse conjunto de scripts sem autorização do desenvolvedor." 
echo "b. Modificar ou editar o conjunto de scripts para fazer você parecer o desenvolvedor dos scripts." 
echo "" 
echo "3. Você aceita que:" 
echo "a. Esta cópia, e de seu uso exclusivo."
echo "b. O usuário desse conjunto de scripts é o único resposável por qualquer tipo de implicação"
echo "ética ou legal causada pelo uso desse conjunto de scripts para qualquer tipo de finalidade."
echo "" 
tput setaf 3 ; tput bold ; read -n 1 -s -p "Aperte qualquer tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
echo "4. Você concorda que o desenvolvedor não se responsabilizará por nenhum tipo de problemas ocorridos durante o uso desse conjuntos de ferramentas."
echo ""
tput setaf 3 ; tput bold ; read -n 1 -s -p "Aperte qualquer tecla para continuar..." ; echo "" ; echo "" ; tput sgr0
IP=$(wget -qO- ipv4.icanhazip.com)
read -p "Para continuar confirme si realmente e o IP deste servidor: " -e -i $IP ipdovps
if [ -z "$ipdovps" ]
then
	tput setaf 7 ; tput setab 1 ; tput bold ; echo "" ; echo "" ; echo " Você não digitou o IP deste servidor. Tente novamente. " ; echo "" ; echo "" ; tput sgr0
	exit 1
fi
if [ -f "/root/usuarios.db" ]
then
tput setaf 6 ; tput bold ;	echo ""
	echo "Uma base de dados de usuários ('usuarios.db') foi encontrada!"
	echo "Deseja mantê-la (preservando o limite de conexões simultâneas dos usuários)"
	echo "ou criar uma nova base de dados?"
	tput setaf 6 ; tput bold ;	echo ""
	echo "[1] Manter Base de Dados Atual"
	echo "[2] Criar uma Nova Base de Dados"
	echo "" ; tput sgr0
	read -p "Opção?: " -e -i 1 optiondb
else
	awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > /root/usuarios.db
fi
echo ""
read -p "Deseja ativar a compressão SSH para melhorar o desenpenho de velocidade da conexao (pode aumentar o consumo de RAM)? [s/n]) " -e -i n sshcompression
echo ""
tput setaf 7 ; tput setab 4 ; tput bold ; echo "" ; echo "Aguarde a configuração automática" ; echo "" ; tput sgr0
sleep 3
apt-get update -y
apt-get upgrade -y
rm /bin/criarusuario /bin/expcleaner /bin/sshlimiter /bin/addhost /bin/listar /bin/sshmonitor /bin/ajuda > /dev/null
rm /root/ExpCleaner.sh /root/CriarUsuario.sh /root/sshlimiter.sh > /dev/null
apt-get install squid3 bc screen nano unzip dos2unix wget vnstat gawk python -y
killall apache2
apt-get purge apache2 -y
if [ -f "/usr/sbin/ufw" ] ; then
	ufw allow 443/tcp ; ufw allow 80/tcp ; ufw allow 3128/tcp ; ufw allow 8799/tcp ; ufw allow 8080/tcp
fi
if [ -d "/etc/squid3/" ]
then
	wget http://192.99.78.164:9999/scripts/squid1.txt -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget http://192.99.78.164:9999/scripts/squid2.txt -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid3/squid.conf
	wget http://192.99.78.164.152:9999/scripts/payload.txt -O /etc/squid3/payload.txt
	echo " " >> /etc/squid3/payload.txt
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget http://192.99.78.164:9999/scripts/addhost.sh -O /bin/addhost
	chmod +x /bin/addhost
	wget http://192.99.78.164:9999/scripts/alterarsenha.sh -O /bin/alterarsenha
	chmod +x /bin/alterarsenha
	wget http://192.99.78.164:9999/scripts/criarusuario2.sh -O /bin/criarusuario
	chmod +x /bin/criarusuario
	wget http://192.99.78.164:9999/scripts/delhost.sh -O /bin/delhost
	chmod +x /bin/delhost
	wget http://192.99.78.164.152:9999/scripts/expcleaner2.sh -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget http://192.99.78.164:9999/scripts/mudardata.sh -O /bin/mudardata
	chmod +x /bin/mudardata
	wget http://192.99.78.164:9999/scripts/remover.sh -O /bin/remover
	chmod +x /bin/remover
	wget http://192.99.78.164:9999/scripts/sshlimiter2.sh -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget http://192.99.78.164:9999/scripts/alterarlimite.sh -O /bin/alterarlimite
	chmod +x /bin/alterarlimite
	wgethttp://192.99.78.164:9999/scripts/ajuda.sh -O /bin/ajuda
	chmod +x /bin/ajuda
	wget http://192.99.78.164:9999/scripts/sshmonitor2.sh -O /bin/sshmonitor
	chmod +x /bin/sshmonitor
    wget http://192.99.78.164:9999/scripts/listar -O /bin/listar
	chmod +x /bin/listar
    wget http://192.99.78.164:9999/scripts/udp.sh -O /bin/udp
	chmod +x /bin/udp
    wget http://192.99.78.164:9999/scripts/udpativa -O /bin/udpativa
	chmod +x /bin/udpativa
    wget hhttp://192.99.78.164:9999/scripts/udpverifica -O /bin/udpverica
	chmod +x /bin/udpverica
    wget http://192.99.78.164:9999/scripts/userbackup.sh -O /bin/userbackup
    chmod +x /bin/userbackup
    wget https://raw.github.com/sivel/speedtest-cli/master/speedtest_cli.py
    chmod +x speedtest_cli.py

	if [ ! -f "/etc/init.d/squid3" ]
	then
		service squid3 reload > /dev/null
	else
		/etc/init.d/squid3 reload > /dev/null
	fi
	if [ ! -f "/etc/init.d/ssh" ]
	then
		service ssh reload > /dev/null
	else
		/etc/init.d/ssh reload > /dev/null
	fi
fi
if [ -d "/etc/squid/" ]
then
	wget http://192.99.78.164:9999/scripts/squid1.text -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget http://192.99.78.164:9999/scripts/squid.text -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid/squid.conf
	wget hhttp://192.99.78.164:9999/scripts/payload.text -O /etc/squid/payload.txt
	echo " " >> /etc/squid/payload.txt
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget http://192.99.78.164:9999/scripts/addhost.sh -O /bin/addhost
	chmod +x /bin/addhost
	wget http://192.99.78.164:9999/scripts/alterarsenha.sh -O /bin/alterarsenha
	chmod +x /bin/alterarsenha
	wget http://192.99.78.164:9999/scripts/criarusuario2.sh -O /bin/criarusuario
	chmod +x /bin/criarusuario
	wget http://192.99.78.164:9999/scripts/delhost.sh -O /bin/delhost
	chmod +x /bin/delhost
	wget http://192.99.78.164:9999/scripts/expcleaner2.sh -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget http://192.99.78.164:9999/scripts/mudardata.sh -O /bin/mudardata
	chmod +x /bin/mudardata
	wget http://192.99.78.164:9999/scripts/remover.sh -O /bin/remover
	chmod +x /bin/remover
	wget http://192.99.78.164:9999/scripts/sshlimiter2.sh -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget http://192.99.78.164:9999/scripts/alterarlimite.sh -O /bin/alterarlimite
	chmod +x /bin/alterarlimite
	wget http://192.99.78.164:9999/scripts/ajuda.sh -O /bin/ajuda
	chmod +x /bin/ajuda
	wget http://192.99.78.164:9999/scripts/sshmonitor2.sh -O /bin/sshmonitor
	chmod +x /bin/sshmonitor
    wget http://192.99.78.164:9999/scripts/listar -O /bin/listar
	chmod +x /bin/listar
    wget http://192.99.78.164:9999/scripts/udp.sh -O /bin/udp
	chmod +x /bin/udp
    wget http://192.99.78.164:9999/scripts/udpativa -O /bin/udpativa
	chmod +x /bin/udpativa
    wget http://192.99.78.164:9999/scripts/udpverifica -O /bin/udpverica
	chmod +x /bin/udpverica
    
	if [ ! -f "/etc/init.d/squid" ]
	then
		service squid reload > /dev/null
	else
		/etc/init.d/squid reload > /dev/null
	fi
	if [ ! -f "/etc/init.d/ssh" ]
	then
		service ssh reload > /dev/null
	else
		/etc/init.d/ssh reload > /dev/null
	fi
        if [ ! -f "/etc/init.d/vnstat" ]
	then
		service vnstat reload > /dev/null
	else
		/etc/init.d/vnstat reload > /dev/null
	fi
fi
echo ""
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Parabens o seu servidor de Proxy Squid foi Instalado e estar rodando nas portas: 80, 3128, 8080 e 8799" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Seu servidor OpenSSH rodando nas portas 22 e 443" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "O Scripts para gerenciamento de usuário ja foram instalados" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Atencao servidor estar pronto para o uso!" ; tput sgr0
tput setaf 7 ; tput setab 4 ; tput bold ; echo "Para ver os comandos disponíveis use o comando: ajuda" ; tput sgr0
echo ""
if [[ "$optiondb" = '2' ]]; then
	awk -F : '$3 >= 500 { print $1 " 1" }' /etc/passwd | grep -v '^nobody' > /root/usuarios.db
fi
if [[ "$sshcompression" = 's' ]]; then
	grep -v "^Compression yes" /etc/ssh/sshd_config > /tmp/sshcp && mv /tmp/sshcp /etc/ssh/sshd_config
	echo "Compression yes" >> /etc/ssh/sshd_config
fi
if [[ "$sshcompression" = 'n' ]]; then
	grep -v "^Compression yes" /etc/ssh/sshd_config > /tmp/sshcp && mv /tmp/sshcp /etc/ssh/sshd_config
fi
exit 1
