#!/bin/bash
####################################################################################################################
#   Author : Spyridakis Christos
#   Created Date : 4/9/2021
#   Last Updated : 23/4/2022
#   Email : spyridakischristos@gmail.com
#
#
#   Description : 
#       Use functions that located to this file, to print important info for my custom tmux theme bar  
#
####################################################################################################################

THEME_CLR="blue"        # colour29,
THEME_CLR2="colour238"  # colour238, 
THEME_FONT_CLR="white"
THEME_FONT_CLR2="black"
THEME_ACT_FONT_CLR=""

MIDDLE_BAR_ACT_CLR="blue" # color238
MIDDLE_BAR_CLR="colour235" # color235
MIDDLE_BAR_ACT_FNT="colour222" # color222
MIDDLE_BAR_FNT="white"     # white

RIGHT_ARROW="" #""
LEFT_ARROW="" #""
MIDDLE_DOT="•"

#Change this variable if you do not want to display arrows
USE_ARROWS=1
if [ ${USE_ARROWS} -eq 0 ] ; then 
    RIGHT_ARROW=""
    LEFT_ARROW=""
fi

function setup_on_system (){ 
    TAR_SCRIPT="`pwd`/tmux-functions.sh"
    DES_SCRIPT="$HOME/.tmux-functions.sh"

    TAR_TMUX="`pwd`/.tmux.conf"
    DES_TMUX="$HOME/.tmux.conf"

    [ ! -e ${DES_SCRIPT} ] && (echo "ln -s ${TAR_SCRIPT} ${DES_SCRIPT}" && ln -s ${TAR_SCRIPT} ${DES_SCRIPT} && echo "Create symlink") || echo "symlink (~/.tmux-functions) already exists" 

    rm -rf "${HOME}/.tmux.conf"
    cp ${TAR_TMUX} ${DES_TMUX} && echo "Generated .tmux.conf file"
}

function helpMenu (){
    echo "Usage: $0 [Option]"
    echo "Use it alongside with .tmux.conf to custumize status bar"
    echo 
    echo "Options:"
    echo "  -h, --help             display this help menu and exit"
    echo "  -l, --left             generate left side content"
    echo "  -r, --right            generate right side content"
    echo "  -s, --setup            generate a symlink of this file to your home dir"
}

# ----------------------------------------------------------------------------------------

function cpu_usage(){
    NUMCPUS=`grep ^proc /proc/cpuinfo | wc -l`
    FIRST=`cat /proc/stat | awk '/^cpu / {print $5}'`
    sleep 1
    SECOND=`cat /proc/stat | awk '/^cpu / {print $5}'`
    USED=`echo 2 k 100 $SECOND $FIRST - $NUMCPUS / - p | dc | tr -d '-'`     # Need to be installed dc
    USED=`echo ${USED} | awk '{printf "%.1f", $0}'`                          # Converts .X to 0.X

    cpu=`echo "${USED}" | cut -d'.' -f1`
    if [[ $cpu -lt 5 ]] ; then
        echo "#[fg=colour47]${USED}% _ "
    elif [[ $cpu -lt 10 ]] ; then
        echo "#[fg=colour47]${USED}% ▁ "
    elif [[ $cpu -lt 20 ]] ; then
        echo "#[fg=colour220]${USED}% ▂ "
    elif [[ $cpu -lt 40 ]] ; then
        echo "#[fg=colour214]${USED}% ▃ "
    elif [[ $cpu -lt 60 ]] ; then
        echo "#[fg=colour208]${USED}% ▄ "
    elif [[ $cpu -lt 80 ]] ; then
        echo "#[fg=colour202]${USED}% ▅ "
    else
        echo "#[fg=colour196]${USED}% ▇ "
    fi
}

function memory_stats() {
    free_mem=`free -h | grep 'Mem\|free' | tr -s ' ' | tail -n 1 | cut -d' ' -f 3 | tr ',' '.'`
    total_mem=`free -h | grep 'Mem\|free' | tr -s ' ' | tail -n 1 | cut -d' ' -f 2 | tr ',' '.'`
    
    echo -n "${free_mem}/${total_mem} "
}

function cpu_temp() {
    # cur_temp=`sensors | grep '°C' | grep 'temp\|Tctl\|Package' | head -n 1 | tr -s ' ' | cut -d' ' -f2 | tr -d '°' | tr -d 'C' | tr -d '+'`
    cur_temp=`sensors | grep '°C' | grep 'temp\|Tctl\|Package' | head -n 1 | grep -o -E '[0-9][0-9].[0-9]°C'| tr '\n' ' ' | tr -s ' ' | cut -d' ' -f1 | tr -d '°' | tr -d 'C' | tr -d '+'`

    temp=`echo "$cur_temp" | cut -d'.' -f1`
    if [[ $temp -lt 30 ]] ; then
        echo "#[fg= color119]${cur_temp}°C "
    elif [[ $temp -lt 40 ]] ; then
        echo "#[fg=colour226]${cur_temp}°C "
    elif [[ $temp -lt 50 ]] ; then
        echo "#[fg=colour220]${cur_temp}°C "
    elif [[ $temp -lt 60 ]] ; then
        echo "#[fg=colour214]${cur_temp}°C "
    elif [[ $temp -lt 70 ]] ; then
        echo "#[fg=colour208]${cur_temp}°C "
    elif [[ $temp -lt 80 ]] ; then
        echo "#[fg=colour202]${cur_temp}°C "
    else
        echo "#[fg=colour196]${cur_temp}°C "
    fi
}

function get_disk_space(){
    local space="`df -h / | tr -s ' ' | tail -n 1`"
    local free_space="`echo ${space} | cut -d' ' -f4`"
    local total_space="`echo ${space} | cut -d' ' -f2`"
    local percentage_used="`echo ${space} | cut -d' ' -f5`"

    local percentage_used_num="`echo ${percentage_used} | tr -d '%'`"
    local print_data="F:${free_space} [U:${percentage_used}] "
    if [[ ${percentage_used_num} -lt 4 ]] ; then
        echo "#[fg=colour196]${print_data}"
    elif [[ ${percentage_used_num} -lt 10 ]] ; then
        echo "#[fg=colour208]${print_data}"
    elif [[ ${percentage_used_num} -lt 15 ]] ; then
       echo "#[fg=colour226]${print_data}"
    else
        echo "#[fg=colour47]${print_data}"
    fi
}

function get_speed(){
    local l_speed=$1

    if [[ ${l_speed} -lt 1000 ]] ; then
        echo "${l_speed} B"
    elif [[ $(( ${l_speed}/1000 )) -lt 100 ]] ; then
        l_speed=`echo "scale=1; ${l_speed}/1000" | bc`
        l_speed="$(echo ${l_speed} | awk '{printf "%.1f", $0}')"
        echo "${l_speed} KB"
    elif [[ $(( ${l_speed}/1000 )) -lt 1000 ]] ; then
        l_speed=`echo "${l_speed}/1000" | bc`
        echo "${l_speed} KB"
    elif [[ $(( ${l_speed}/1000000 )) -lt 100 ]] ; then
        l_speed=`echo "scale=2; ${l_speed}/1000000" | bc`
        l_speed="$(echo ${l_speed} | awk '{printf "%.1f", $0}')"
        echo "${l_speed} MB"
    elif [[ $(( ${l_speed}/1000000 )) -lt 1000 ]] ; then
        l_speed=`echo "${l_speed}/1000000" | bc`
        echo "${l_speed} MB"
    fi
}

function net_up_traffic(){
    interface=`interface_name`

    old_tx=`cat /sys/class/net/${interface}/statistics/tx_bytes`
    sleep 1
    now_tx=`cat /sys/class/net/${interface}/statistics/tx_bytes`
    speed_tx=$(($now_tx-$old_tx))

    echo "`get_speed ${speed_tx}`"
}

function net_down_traffic(){
    interface=`interface_name`

    old_rx=`cat /sys/class/net/${interface}/statistics/rx_bytes`
    sleep 1
    now_rx=`cat /sys/class/net/${interface}/statistics/rx_bytes`
    speed_rx=$(($now_rx-$old_rx))

    echo "`get_speed ${speed_rx}`" 
}

function net_traffic(){
    echo "#[fg=colour121]↖ `net_up_traffic` ↘ `net_down_traffic`" 
}

function battery_level(){
    echo -n ""
}

function local_ip(){
    echo "`hostname -I | awk '{print $1}'`"
}

function wan_ip(){
    echo -n "`curl ifconfig.me`"
}

function interface_name(){
    ip a | grep -B 2 `local_ip` | head -n 1 | tr -s ' ' | tr -d ' ' | cut -d ":" -f 2
}

# ----------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------

function cecho() {
    if   [ "$1" == "-b" ]  ; then   echo -n " #[$2]$3"      # Space Before
    elif [ "$1" == "-a" ]  ; then   echo -n "#[$2]$3 "      # Space After
    elif [ "$1" == "-m" ]  ; then   echo -n "#[$2] $3"      # Space in Middle
    elif [ "$1" == "-e" ]  ; then   echo -n " #[$2] $3 "    # Space in Every
    elif [ "$1" == "-ft" ] ; then   echo -n " #[$2] $3"     # Space in First Two
    elif [ "$1" == "-lt" ] ; then   echo -n "#[$2] $3 "     # Space in Last Two
    elif [ "$1" == "-fl" ] ; then   echo -n " #[$2]$3 "     # Space in First & Last
    elif [ "$1" == "-r" ]  ; then   echo -n "#[$2] $3"      # Use normaly for right status
    elif [ "$1" == "-l" ]  ; then   echo -n " #[$2]$3 "     # Use normaly for left status
    else                            echo -n "#[$2] $3"      # Default
    fi
}

# ---------------

function left_status (){
    # Session's name
    str=`cecho "-ft" "fg=${THEME_FONT_CLR},bg=${THEME_CLR}" "#S"`            

    #  --- SEPARATOR ---                          
    str+=`cecho "-l" "fg=${THEME_CLR},bg=${THEME_CLR2},nobold,nounderscore,noitalics" ${RIGHT_ARROW}`              

    # Local IP address
    str+=`cecho "-l" "fg=colour222,bg=${THEME_CLR2}" "$(local_ip)"`

    #  --- SEPARATOR --- 
    str+=`cecho "-l" "fg=${THEME_CLR2},bg=colour235,nobold,nounderscore,noitalics" ${RIGHT_ARROW}`

    # Network traffic stats
    str+=`cecho "-l" "fg=colour121,bg=colour235" "$(get_disk_space) $(net_traffic)"`

    #  --- SEPARATOR ---  
    str+=`cecho "-l" "fg=colour235,bg=colour235,nobold,nounderscore,noitalics" ${RIGHT_ARROW}`

    echo $str
}

# ---------------

function right_status (){
    #  --- SEPARATOR ---  
    str=`cecho "-r" "fg=colour235,bg=colour235,nobold,nounderscore,noitalics" ${LEFT_ARROW}`

    # Computer Stats
    str+=`cecho "-r" "fg=colour121,bg=colour235" "$(memory_stats) $(cpu_temp) $(cpu_usage)"`

    #  --- SEPARATOR ---  
    str+=`cecho "-r" "fg=${THEME_CLR2},bg=colour235,nobold,nounderscore,noitalics" ${LEFT_ARROW}`

    # User
    str+=`cecho "-r" "fg=colour222,bg=${THEME_CLR2}" "#H"`

    #  --- SEPARATOR ---  
    str+=`cecho "-r" "fg=${THEME_CLR},bg=${THEME_CLR2},nobold,nounderscore,noitalics" ${LEFT_ARROW}`

    # Empty space
    str+=`cecho "-lt" "fg=colour232,bg=${THEME_CLR}" "#(rainbarf --battery --remaining --no-rgb)"`

    echo $str
}



# ---------------

function middle_format_active(){
    str=""
    str+="#[fg=${MIDDLE_BAR_ACT_CLR},bg=${MIDDLE_BAR_CLR},nobold,nounderscore,noitalics]${LEFT_ARROW}"
    str+="#[fg=${MIDDLE_BAR_ACT_FNT},bg=${MIDDLE_BAR_ACT_CLR}] #I #{?window_zoomed_flag,⩹ ,}#W#{?window_zoomed_flag, ⩺,} "
    str+="#[fg=${MIDDLE_BAR_ACT_CLR},bg=${MIDDLE_BAR_CLR},nobold,nounderscore,noitalics]${RIGHT_ARROW}"
    echo $str
}

# ---------------


function middle_format(){
    str=""
    str+="#[fg=${MIDDLE_BAR_CLR},bg=${MIDDLE_BAR_CLR},nobold,nounderscore,noitalics]${RIGHT_ARROW}"
    str+="#[fg=${MIDDLE_BAR_FNT},bg=${MIDDLE_BAR_CLR}]#I #W "
    str+="#[fg=${MIDDLE_BAR_CLR},bg=${MIDDLE_BAR_CLR},nobold,nounderscore,noitalics]${RIGHT_ARROW}"
    echo $str
}



# ----------------------------------------------------------------------------------------

while :
do
    case "$1" in
        -h | --help)                helpMenu ;                  exit 0;;
        -l | --left)                left_status;                exit 0;;
        -m | --middle)              middle_format;              exit 0;;
        -M | --middle-active)       middle_format_active;       exit 0;;
        -r | --right)               right_status;               exit 0;;
        -s | --setup)               setup_on_system;            exit 0;;

        --*)
            echo "Unknown option: $1" >&2
            helpMenu
            exit 1
            ;;
        -*)
            echo "Unknown option: $1" >&2
            helpMenu
            exit 1 
            ;;
        *) 
            break
    esac
done
