#!/bin/bash
source $HOME/cloudflared//Colors.sh
clear
trap ctrl_c 2
function ctrl_c {
echo
echo -e ${rojo}"[+]$W Finalizado"
echo -e ${rojo}"[+]$W Code by KING"
echo
echo 
exit
}
dependencia(){
printf "\e[1;92m"
command -v wget > /dev/null 2>&1 || { echo -e >&2 "Requiero wget. Por favor instalalo. Abortando... \e[0m"; sleep 2; exit 1; }
command -v neofetch > /dev/null 2>&1 || { echo -e >&2 "Requiero neofetch. Por favor instalalo. Abortando... \e[0m"; sleep 2; exit 1; }
}

function run {
neofetch > neo
OS=$(cat neo |grep OS |cut -d ":" -f2)
OS1=$(uname -o)
echo
echo
echo -e "${rojo}[+]${rojo} Detectanto SO..."
sleep 2
echo -e "${rojo}[+]${rojo} Espere..."
sleep 2
if [ "${OS1}" == "Android" ]; then
echo -e "$G[+]${rojo} SO Detectado${C} :${G} Termux ($OS)"
sleep 0.8
menu-ocp
elif [ "${OS1}" == "GNU/Linux" ]; then
echo -e "$G[+]${rojo} SO Detectado${C} :${blanco} $OS"
sleep 0.8
if [[ -f neo ]]; then
rm neo
fi
menu-ocp
fi
}
function banner {

echo -e ${azul}"  ____ _                 _  __ _                    _ "
echo -e " / ___| | ___  _   _  __| |/ _| | __ _ _ __ ___  __| |"
echo -e "| |   | |/ _ 1| | | |/ _1 | |_| |/ _  |  __/ _ \/ _1 |"
echo -e "| |___| | (_) | |_| | (_| |  _| | (_| | | |  __/ (_| |"
echo -e " \____|_|\___/ \__,_|\__,_|_| |_|\__,_|_|  \___|\__,_|"
echo -e "                ${WR}create by KING$reset"
echo -e "        $WG https://github.com/KingHackers001 $reset"
}
function cloudflared-download {
echo -e ${azul}
echo -e "[+]Descargando cloudflared ..."
echo -e "[--]"
case `dpkg --print-architecture` in
aarch64)
    arquitectura="arm64" ;;
arm)
    arquitectura="arm" ;;
armhf)
    arquitectura="arm" ;;
amd64)
    arquitectura="amd64" ;;
i*86)
    arquitectura="386" ;;
x86_64)
    arquitectura="amd64" ;;
*)
    echo "$R[$Y!!$R] Arquitectura no soportada :("
esac
wget -q --show-progress https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-${arquitectura} -O cloudflared
}
function cloudflared-install {
OS1=$(uname -o)
if [ "$OS1" == "Android" ]; then
chmod 777 cloudflared
mv cloudflared $PREFIX/bin
if [ -f $PREFIX/bin/ngrok ]; then
echo -e "$azul[+]$blanco"
echo -e "$azul[+]$blanco Listo"
echo -e "$azul[+]$blanco Para usar ejecute : cloudflared tunnel -url 127.0.0.1:<puerto>"
echo -e "$azul[+]$blanco Ejemplo : cloudflared tunnel -url 127.0.0.1:8080"
echo
echo
exit 1
fi
elif [ "$OS1" == "GNU/Linux" ]; then
chmod 777 cloudflared
mv cloudflared /usr/local/bin
if [ -f /usr/local/bin/cloudflared ]; then
echo -e "{$rojo}[+]{$rojo}"
echo -e "{$rojo}[+]{$rojo} Listo"
echo -e "{$rojo}[+]{$rojo} Para usar ejecute : cloudflared tunnel -url 127.0.0.1:<puerto>"
echo -e "{$rojo}[+]{$rojo} Ejemplo : cloudflared tunnel -url 127.0.0.1:8080"
echo
echo
exit 1
fi
fi
}
function menu-ocp {
echo
echo
echo -e "       ${azul}[${azul} 01${azul} ]${azul} Descargar e instalar cloudflared"
echo -e "       ${azul}[${azul} 02${azul} ]${azul} GitHub"
echo -e "       ${azul}[${azul} 03${azul} ]${azul} Contacto con el desarrollador"
echo -e "       ${azul}[${azul} 04${azul} ]${azul} Salir :)"
echo
echo 
ocp
}
function ocp {
echo -e -n "$blanco[ elija del 1 al 4 ] > "
read -r a
case $a in
  1|01)
    cloudflared-download
    cloudflared-install
    ;;
  2|02)
    OS1=$(uname -o)
    if [ "$OS1" == "Android" ]; then
    termux-open https://github.com/KingHackers001/
    ocp
    elif [ "$OS1" == "GNU/Linux" ]; then
    echo -e "${G}GIT HUB$W => ${Y}https://github.com/KingHackers/"
    fi
    ocp
    ;;
  3|03)
    echo 
	echo
	echo -e "$rojo=========================="
	echo -e "${rojo}CONTACTO DEL DESARROLLADOR"
	echo -e "$rojo=========================="
	echo 
	echo -e "${rojo}WhatsApp ==> +595 972280390"
	echo
	echo
    ocp
    ;;
  4|04)
    echo -e "$rojo[$Y!!$rojo] SALIENDO ..."
    echo
    exit 1
    ;;
  *)
    if [[ "$a" != "" ]]; then
	echo -e "$rojo[${rojo}!!$rojo] Comando invalido: ${a}"
    sleep 0.5
    ocp
    else
    ocp
    fi
	;;
esac
}
dependencia
banner
run
