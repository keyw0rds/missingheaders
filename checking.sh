#!/bin/bash

# Color
PP='\033[95m' # purple
CY='\033[96m' # cyan
BL='\033[94m' # blue
GR='\033[92m' # green
YW='\033[93m' # yellow
RD='\033[91m' # red
NT='\033[97m' # netral
O='\e[0m' # nothing
B='\e[5m' # blink
U='\e[4m' # underline

function banner(){
	printf "${YW}
   ___ _____      
  /\ (_)    \ \n /  \      (_,
 _)  _\   _    \  ${CY}Missing Security Headers Scanner... ${YW}
/   (_)\_( )____\ ${CY}        Author : Hidayat   ${YW}
\_     /    _  _/
  ) /\/  _ (o)(
  \ \_) (o)   /
   \/________/ 
"
    printf "${CY}"
	read -p "headers@target> " url;
}

function scanner_xss(){
	local xss=$(curl -s https://api.hackertarget.com/httpheaders/?q=$url)
	if [[ $xss =~ 'x-xss-protection' ]]; then
           printf "${NT}[${BL}Not Missing${NT}] X-XSS-Protection Found in Headers...\n"
           printf " ${GR}>>> ${NT}Cross Site Scripting (XSS) Vulnerability Status : False...\n"
    else
    	   printf "${NT}[${RD}Missing${NT}] X-XSS-Protection Not Found in Headers...\n"
    	   printf " ${RD}>>> ${NT}Cross Site Scripting (XSS) Vulnerability Status : True...\n"
    fi
}

function scanner_xframe(){
	local xframe=$(curl -s https://api.hackertarget.com/httpheaders/?q=$url)
	if [[ $xframe =~ 'x-frame-options' ]]; then
           printf "${NT}[${BL}Not Missing${NT}] X-Frame-Options Found in Headers...\n"
           printf " ${GR}>>> ${NT}Clickjacking Vulnerability Status : False...\n"
    else
    	   printf "${NT}[${RD}Missing${NT}] X-Frame-Options Not Found in Headers...\n"
    	   printf " ${RD}>>> ${NT}Clickjacking Vulnerability Status : True...\n"
    fi
}

function scanner_csp(){
	local csp=$(curl -s https://api.hackertarget.com/httpheaders/?q=$url)
	if [[ $csp =~ 'content-security-policy' ]]; then
           printf "${NT}[${BL}Not Missing${NT}] Content-Security-Policy Found in Headers...\n"
           printf " ${GR}>>> ${NT}Cross Site Scripting (XSS) Vulnerability Status : False...\n"
           printf " ${GR}>>> ${NT}Command Injection Server Vulnerability Status : False...\n"
    else
    	   printf "${NT}[${RD}Missing${NT}] Content-Security-Policy Not Found in Headers...\n"
    	   printf " ${RD}>>> ${NT}Cross Site Scripting (XSS) Vulnerability Status : True...\n"
    	   printf " ${RD}>>> ${NT}Command Injection Server Vulnerability Status : False...\n"
    fi
}

function scanner_hsts(){
	local hsts=$(curl -s https://api.hackertarget.com/httpheaders/?q=$url)
	if [[ $hsts =~ 'strict-transport-security' ]]; then
           printf "${NT}[${BL}Not Missing${NT}] Strict-Transport-Security Found in Headers...\n"
    else
    	   printf "${NT}[${RD}Missing${NT}] Strict-Transport-Security Not Found in Headers...\n"
    fi
}

function scanner_hpkp(){
	local hpkp=$(curl -s https://api.hackertarget.com/httpheaders/?q=$url)
	if [[ $hpkp =~ 'public-key-pins' ]]; then
           printf "${NT}[${BL}Not Missing${NT}] Public-Key-Pins Found in Headers...\n"
           printf " ${GR}>>> ${NT}SSL Certificate : True...\n"
    else
    	   printf "${NT}[${RD}Missing${NT}] Public-Key-Pins Not Found in Headers...\n"
    	   printf " ${RD}>>> ${NT}SSL Certificate : False...\n"
    fi
}

function scanner_xss(){
	local xss=$(curl -s https://api.hackertarget.com/httpheaders/?q=$url)
	if [[ $xss =~ 'x-content-type' ]]; then
           printf "${NT}[${BL}Not Missing${NT}] X-Content-Type Found in Headers...\n"
           printf " ${GR}>>> ${NT}Filtering File Upload : True...\n"
    else
    	   printf "${NT}[${RD}Missing${NT}] X-Content-Type Not Found in Headers...\n"
    	   printf " ${RD}>>> ${NT}Filtering File Upload : True...\n"
    fi
}

function run(){
	clear && sleep 3
	banner
	sleep 3
	scanner_xss
	sleep 3
	scanner_hpkp
	sleep 3
	scanner_hsts
	sleep 3
	scanner_csp
	sleep 3
	scanner_xframe
}

run
