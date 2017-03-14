#!/bin/bash
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%30s%s%-10s\n' "Comandos disponíveis:" ; tput sgr0 ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "addhost " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Adicionar domínio 'host' a lista de domínios permitidos no Proxy Squid" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "alterarlimite " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Alterar o número máximo de conexões simultâneas permitidas para um usuário" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "alterarsenha " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Alterar a senha de um usuário" ; echo "" ;
tput setaf 2 ; tput bold ; printf '%s' "criarusuario " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Criar usuário SSH sem acesso ao terminal e com data de expiração" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "delhost " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Remover domínio 'host' da lista de domínios permitidos noser Proxy Squid" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "expcleaner " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Remover usuários SSH expirados" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "mudardata " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Mudar a data de expiração de um usuário" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "remover " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Remover um usuário SSH" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "sshlimiter " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Limitador de conexões SSH simultâneas (deve ser executado em uma sessão screen)" ; echo ""
tput setaf 2 ; tput bold ; printf '%s' "sshmonitor " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Verifica o número de conexão simutânea de cada usuário" ; echo ""
tput sgr0
tput setaf 2 ; tput bold ; printf '%s' "vnstat " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "grafico de uso de dados" ; echo ""
tput sgr0
tput setaf 2 ; tput bold ; printf '%s' "listar " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "listar todos usuarios" ; echo ""
tput sgr0
tput setaf 2 ; tput bold ; printf '%s' "free -m -t " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Ver uso da memoria ram" ; echo ""
tput sgr0
tput setaf 2 ; tput bold ; printf '%s' "df -h " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "Ver uso do HD" ; echo ""
tput sgr0
tput setaf 2 ; tput bold ; printf '%s' "./speedtest_cli.py " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "verificar a velocidade da conexão" ; echo ""
tput sgr0
tput setaf 2 ; tput bold ; printf '%s' "userbackup " ; tput setaf 7 ; printf '%s' "- " ; tput setaf 3 ; echo "criarbackup ou resstaurar" ; echo ""
tput sgr0
