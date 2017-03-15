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
	wget https://www.dropbox.com/s/qv84zhilsufiluj/squid1.txt?dl=1 -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget https://www.dropbox.com/s/mpljwbrlbh99zjz/squid2.txt?dl=1 -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid3/squid.conf
	wget https://www.dropbox.com/s/nkhvs67n6cuh977/payload.txt?dl=1 -O /etc/squid3/payload.txt
	echo " " >> /etc/squid3/payload.txt
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget wget https://www.dropbox.com/s/eyxn7yhk4brazl6/addhost.sh?dl=1 -O /bin/addhost
	chmod +x /bin/addhost
	wget https://www.dropbox.com/s/1somvu8g60qbg5h/alterarsenha.sh?dl=1 -O /bin/alterarsenha
	chmod +x /bin/alterarsenha
	wget https://www.dropbox.com/s/u00f1ak0ve06bt6/criarusuario2.sh?dl=1 -O /bin/criarusuario
	chmod +x /bin/criarusuario
	wget https://www.dropbox.com/s/9keqthlua2uls8n/delhost.sh?dl=1 -O /bin/delhost
	chmod +x /bin/delhost
	wget https://www.dropbox.com/s/slocs0ynrs5vqjn/expcleaner2.sh?dl=1 -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget https://www.dropbox.com/s/sthg0gv0oqi738z/mudardata.sh?dl=1 -O /bin/mudardata
	chmod +x /bin/mudardata
	wget https://www.dropbox.com/s/hki652x2y0cdmng/remover.sh?dl=1 -O /bin/remover
	chmod +x /bin/remover
	wget https://www.dropbox.com/s/zzbk86yib3yjwct/sshlimiter2.sh?dl=1 -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget https://www.dropbox.com/s/chs1ee4pac8vmke/alterarlimite.sh?dl=1 -O /bin/alterarlimite
	chmod +x /bin/alterarlimite
	wget https://www.dropbox.com/s/79hjyokkdjpz2c1/ajuda.sh?dl=1 -O /bin/ajuda
	chmod +x /bin/ajuda
	wget https://www.dropbox.com/s/zs7eouoo6ylgavt/sshmonitor2.sh?dl=1 -O /bin/sshmonitor
	chmod +x /bin/sshmonitor
        wget https://www.dropbox.com/s/2gaej4luu97g02d/listar?dl=1 -O /bin/listar
	chmod +x /bin/listar
        wget https://www.dropbox.com/s/g3bn8rmmcol77bs/udp.sh?dl=1 -O /bin/udp
	chmod +x /bin/udp
        wget https://www.dropbox.com/s/w37e26z0cqt198b/udpativa?dl=1 -O /bin/udpativa
	chmod +x /bin/udpativa
        wget https://www.dropbox.com/s/nqyxoi3grusbs6h/udpverifica?dl=0 -O /bin/udpverica
	chmod +x /bin/udpverica
        wget https://www.dropbox.com/s/7o0o5dhx52h0yzs/userbackup.sh?dl=1 -O /bin/userbackup
        chmod +x /bin/userbackup
        wget https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py -O speedtest-cli
        chmod +x speedtest-cli
        mv speedtest-cli /usr/bin/speedtest-cli
        wget https://www.dropbox.com/s/4kxfhy7yo3b1yfc/vpn.sh?dl=1 -O /bin/vpn
        chmod +x /bin/vpn

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
        if [ ! -f "/etc/init.d/vnstat" ]
	then
		service vnstat reload > /dev/null
	else
		/etc/init.d/vnstat restart > /dev/null
	fi
fi
if [ -d "/etc/squid/" ]
then
	wget https://www.dropbox.com/s/qv84zhilsufiluj/squid1.txt?dl=1 -O /tmp/sqd1
	echo "acl url3 dstdomain -i $ipdovps" > /tmp/sqd2
	wget https://www.dropbox.com/s/i0j4zjceu2jr9ke/squid.txt?dl=1 -O /tmp/sqd3
	cat /tmp/sqd1 /tmp/sqd2 /tmp/sqd3 > /etc/squid/squid.conf
	wget https://www.dropbox.com/s/nkhvs67n6cuh977/payload.txt?dl=1 -O /etc/squid/payload.txt
	echo " " >> /etc/squid/payload.txt
	grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
	echo "Port 443" >> /etc/ssh/sshd_config
	grep -v "^PasswordAuthentication yes" /etc/ssh/sshd_config > /tmp/passlogin && mv /tmp/passlogin /etc/ssh/sshd_config
	echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
	wget wget https://www.dropbox.com/s/eyxn7yhk4brazl6/addhost.sh?dl=1 -O /bin/addhost -O /bin/addhost
	chmod +x /bin/addhost
	wget https://www.dropbox.com/s/1somvu8g60qbg5h/alterarsenha.sh?dl=1 -O /bin/alterarsenha
	chmod +x /bin/alterarsenha
	wget https://www.dropbox.com/s/u00f1ak0ve06bt6/criarusuario2.sh?dl=1 -O /bin/criarusuario
	chmod +x /bin/criarusuario
	wget https://www.dropbox.com/s/9keqthlua2uls8n/delhost.sh?dl=1 -O /bin/delhost
	chmod +x /bin/delhost
	wget https://www.dropbox.com/s/slocs0ynrs5vqjn/expcleaner2.sh?dl=1 -O /bin/expcleaner
	chmod +x /bin/expcleaner
	wget https://www.dropbox.com/s/sthg0gv0oqi738z/mudardata.sh?dl=1 -O /bin/mudardata
	chmod +x /bin/mudardata
	wget https://www.dropbox.com/s/hki652x2y0cdmng/remover.sh?dl=1 -O /bin/remover
	chmod +x /bin/remover
	wget https://www.dropbox.com/s/zzbk86yib3yjwct/sshlimiter2.sh?dl=1 -O /bin/sshlimiter
	chmod +x /bin/sshlimiter
	wget https://www.dropbox.com/s/chs1ee4pac8vmke/alterarlimite.sh?dl=1 -O /bin/alterarlimite
	chmod +x /bin/alterarlimite
	wget https://www.dropbox.com/s/79hjyokkdjpz2c1/ajuda.sh?dl=1 -O /bin/ajuda
	chmod +x /bin/ajuda
	wget https://www.dropbox.com/s/zs7eouoo6ylgavt/sshmonitor2.sh?dl=1 -O /bin/sshmonitor
	chmod +x /bin/sshmonitor
        wget https://www.dropbox.com/s/2gaej4luu97g02d/listar?dl=1 -O /bin/listar
	chmod +x /bin/listar
        wget https://www.dropbox.com/s/g3bn8rmmcol77bs/udp.sh?dl=1 -O /bin/udp
	chmod +x /bin/udp
        wget https://www.dropbox.com/s/w37e26z0cqt198b/udpativa?dl=1 -O /bin/udpativa
	chmod +x /bin/udpativa
        wget https://www.dropbox.com/s/nqyxoi3grusbs6h/udpverifica?dl=1 -O /bin/udpverica
	chmod +x /bin/udpverica
        wget https://www.dropbox.com/s/7o0o5dhx52h0yzs/userbackup.sh?dl=1 -O /bin/userbackup
        chmod +x /bin/userbackup
        wget https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py -O speedtest-cli
        chmod +x speedtest-cli
        mv speedtest-cli /usr/bin/speedtest-cli
        wget https://www.dropbox.com/s/4kxfhy7yo3b1yfc/vpn.sh?dl=1 -O /bin/vpn
        chmod +x /bin/vpn
    
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
		/etc/init.d/vnstat restart > /dev/null
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
