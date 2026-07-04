#!/bin/bash
####################################################################################################################
#   Author : Spyridakis Christos
#   Created Date : 4/9/2021
#   Last Updated : 3/7/2026
#   Email : spyridakischristos@gmail.com
#
#
#   Description :
#       Use functions that located to this file, to print important info for my custom tmux theme bar
#
####################################################################################################################

# ============================================================================
#  PALETTE — 256-color family, modernized. Dark gray base + soft bright blue
#  accent + spectrum thresholds. Same family as before, slightly warmer/softer.
# ============================================================================
BG="colour235"        # #262626 — status bar base (original)
SURFACE="colour237"   # #3a3a3a — segment surface (original)
FG="colour231"        # #ffffff — primary text (pure white)
SUBFG="colour251"     # #c6c6c6 — secondary text (more legible)
ACCENT="colour39"     # #00afff — crisp electric blue (session/host bookends)
ACCENT_FG="colour232" # #080808 — near-black text sitting on accent
GOOD="colour41"       # #00d75f — punchy green (low load / cool temp / low usage)
COOL="colour51"       # #00ffff — vivid cyan (net widget)
WARN="colour220"      # #ffd700 — sharp gold (rising)
WARN2="colour208"     # #ff8700 — sharp orange (high)
DANGER="colour196"    # #ff0000 — bold red (critical)
MUTED="colour244"     # #808080 — gray placeholder ("--")

# Aliases kept for backward-compat with status bar helpers
THEME_CLR="${ACCENT}"
THEME_CLR2="${SURFACE}"
THEME_FONT_CLR="${ACCENT_FG}"
THEME_FONT_CLR2="${FG}"
THEME_ACT_FONT_CLR=""

# Window list (middle bar)
MIDDLE_BAR_ACT_CLR="${ACCENT}"
MIDDLE_BAR_CLR="${BG}"
MIDDLE_BAR_ACT_FNT="${ACCENT_FG}"
MIDDLE_BAR_FNT="${SUBFG}"

RIGHT_ARROW=""
LEFT_ARROW=""
MIDDLE_DOT="•"

# OS detection
case "$(uname -s)" in
    Darwin) OS="macos" ;;
    Linux)  OS="linux" ;;
    *)      OS="unknown" ;;
esac

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
    echo "  --net-debug            print interface selection + net counters (diagnostic)"
    echo
    echo "Env vars:"
    echo "  TMUX_NET_IFACE         force a specific interface (e.g. wlan0)"
}

function net_debug(){
    echo "OS: $OS"
    echo "TMUX_NET_IFACE (override): ${TMUX_NET_IFACE:-<unset>}"
    echo
    echo "Default-route candidates (metric iface):"
    if command -v ip >/dev/null 2>&1; then
        ip -4 route show default 2>/dev/null | sed 's/^/  ip: /'
    fi
    if [ -r /proc/net/route ]; then
        echo "  /proc/net/route defaults:"
        awk 'NR>1 && $2=="00000000" {printf "    metric=%s iface=%s\n", $7, $1}' /proc/net/route
    fi
    echo
    echo "Physical interfaces (have /sys/class/net/*/device):"
    for d in /sys/class/net/*; do
        n=$(basename "$d")
        [ "$n" = "lo" ] && continue
        if [ -e "$d/device" ]; then
            state=$(cat "$d/operstate" 2>/dev/null)
            printf "  %-12s state=%s\n" "$n" "$state"
        fi
    done
    echo
    local iface; iface=$(interface_name)
    echo "Selected interface: '${iface:-<none>}'"
    if [ -n "$iface" ] && [ -r "/sys/class/net/$iface/statistics/rx_bytes" ]; then
        echo "  rx_bytes=$(cat /sys/class/net/$iface/statistics/rx_bytes)"
        echo "  tx_bytes=$(cat /sys/class/net/$iface/statistics/tx_bytes)"
    fi
    echo
    echo "1-second sample (rx_delta tx_delta):"
    net_sample
}

#------------------------------------------------------------------------------------

# Cross-platform: return primary network interface.
# Preference order:
#   1. $TMUX_NET_IFACE override (user pin)
#   2. Default-route iface that is PHYSICAL (has /sys/class/net/<x>/device)
#      -> skips VPN (tun/wg), docker (docker0/br-*/veth*), virtualbox, etc.
#   3. Any default-route iface (lowest metric)
#   4. First physical iface that is up
function interface_name(){
    # 1. Override
    if [ -n "$TMUX_NET_IFACE" ]; then
        echo "$TMUX_NET_IFACE"; return
    fi

    if [ "$OS" = "macos" ]; then
        route -n get default 2>/dev/null | awk '/interface:/ {print $2; exit}'
        return
    fi

    # Collect default-route interfaces with metrics: "<metric> <iface>"
    local candidates=""
    if command -v ip >/dev/null 2>&1; then
        candidates=$(ip -4 route show default 2>/dev/null | awk '{
            iface=""; metric=0
            for (i=1;i<=NF;i++) {
                if ($i=="dev")    iface=$(i+1)
                if ($i=="metric") metric=$(i+1)
            }
            if (iface != "") print metric, iface
        }')
    elif [ -r /proc/net/route ]; then
        # /proc/net/route fields: Iface Dest Gateway Flags Refcnt Use Metric ...
        candidates=$(awk 'NR>1 && $2=="00000000" {print $7, $1}' /proc/net/route)
    fi

    # 2. Prefer physical (has /sys/class/net/<iface>/device), lowest metric first
    local iface=""
    iface=$(echo "$candidates" | sort -n | while read -r _m name; do
        [ -z "$name" ] && continue
        [ -e "/sys/class/net/$name/device" ] && { echo "$name"; break; }
    done)

    # 3. Fallback: any default-route iface
    if [ -z "$iface" ]; then
        iface=$(echo "$candidates" | sort -n | awk 'NR==1 {print $2}')
    fi

    # 4. Last resort: first physical iface that is up
    if [ -z "$iface" ]; then
        local d n state
        for d in /sys/class/net/*; do
            n=$(basename "$d")
            [ "$n" = "lo" ] && continue
            [ -e "$d/device" ] || continue
            state=$(cat "$d/operstate" 2>/dev/null)
            [ "$state" = "up" ] && iface="$n" && break
        done
    fi
    echo "$iface"
}

# Cross-platform: return primary local IPv4, padded to fixed width (15 = xxx.xxx.xxx.xxx)
function local_ip(){
    local ip=""
    if [ "$OS" = "macos" ]; then
        local dev; dev=$(interface_name)
        if [ -n "$dev" ] && command -v ipconfig >/dev/null 2>&1; then
            ip=$(ipconfig getifaddr "$dev" 2>/dev/null)
        fi
        [ -z "$ip" ] && ip=$(ifconfig 2>/dev/null | awk '/inet / && $2 != "127.0.0.1" {print $2; exit}')
    else
        if command -v hostname >/dev/null 2>&1 && hostname -I >/dev/null 2>&1; then
            ip=$(hostname -I 2>/dev/null | awk '{print $1}')
        elif command -v ip >/dev/null 2>&1; then
            ip=$(ip -4 -o addr show scope global 2>/dev/null | awk '{print $4; exit}' | cut -d/ -f1)
        else
            ip=$(ifconfig 2>/dev/null | awk '/inet / && $2 != "127.0.0.1" {print $2; exit}')
        fi
    fi
    echo -n "${ip:-N/A}"
}

function wan_ip(){
    echo -n "`curl -s ifconfig.me`"
}

# CPU usage (cross-platform, awk-only math, fixed width)
function cpu_usage(){
    local used=""
    if [ "$OS" = "macos" ]; then
        used=$(top -l 2 -n 0 -s 1 2>/dev/null | awk -F'[ ,%]+' '/CPU usage/ {u=$3+$5} END {printf "%.1f", u+0}')
    else
        local numcpus first second
        numcpus=$(grep -c ^processor /proc/cpuinfo 2>/dev/null)
        [ -z "$numcpus" ] || [ "$numcpus" = "0" ] && numcpus=1
        first=$(awk '/^cpu / {print $5}' /proc/stat 2>/dev/null)
        sleep 1
        second=$(awk '/^cpu / {print $5}' /proc/stat 2>/dev/null)
        used=$(awk -v s="${second:-0}" -v f="${first:-0}" -v n="$numcpus" \
            'BEGIN { d=(s-f)/n; u=100-d; if (u<0) u=-u; printf "%.1f", u }')
    fi
    # No sample available -> placeholder in muted gray
    if [ -z "$used" ]; then
        printf "#[fg=%s]%-4s %s" "$MUTED" "--%" "-"
        return
    fi

    # Color + bar-glyph based on load (7 tiers: cool -> warm -> hot)
    local cpu color char; cpu=${used%.*}
    if   [[ $cpu -lt 5  ]] ; then color="$GOOD";   char="_"
    elif [[ $cpu -lt 10 ]] ; then color="$GOOD";   char="▁"
    elif [[ $cpu -lt 20 ]] ; then color="$WARN";   char="▂"
    elif [[ $cpu -lt 40 ]] ; then color="$WARN";   char="▃"
    elif [[ $cpu -lt 60 ]] ; then color="$WARN2";  char="▄"
    elif [[ $cpu -lt 80 ]] ; then color="$WARN2";  char="▅"
    else                          color="$DANGER"; char="▇"
    fi
    # Fixed 6-col widget: left-justified "N%" in 4 cols + space + 1-col bar.
    # Left-justify keeps value glued to left edge -> 2-space gap after temp
    # stays constant regardless of digit count (1/2/3 digits).
    local pct_s; pct_s=$(printf '%d%%' "$cpu")
    printf "#[fg=%s]%-4s %s" "$color" "$pct_s" "$char"
}

# Memory (cross-platform, fixed width)
function memory_stats() {
    local used_h="" total_h="" mac_pct=""
    if [ "$OS" = "macos" ]; then
        # Match btop's formula (host_statistics64 HOST_VM_INFO64):
        #   available = free + file_backed + purgeable
        #   used      = total - available
        # Fields map to vm_stat labels:
        #   free        = "Pages free"          (free_count)
        #   file_backed = "File-backed pages"   (external_page_count)
        #   purgeable   = "Pages purgeable"     (purgeable_count)
        # $NF is used because vm_stat's label word-count varies per line.
        # Single vm_stat call: cheaper + guarantees a consistent snapshot.
        local total pagesize free_p file_p purge_p avail used vm
        total=$(sysctl -n hw.memsize 2>/dev/null)
        pagesize=$(sysctl -n hw.pagesize 2>/dev/null); pagesize=${pagesize:-4096}
        vm=$(vm_stat 2>/dev/null)
        # Strip any non-digit from the last field (defensive against locale
        # decimal marks or unusual label spacing across macOS versions).
        free_p=$(printf '%s\n'  "$vm" | awk '/^Pages free/         {n=$NF; gsub(/[^0-9]/,"",n); print n+0; exit}')
        file_p=$(printf '%s\n'  "$vm" | awk '/^File-backed pages/  {n=$NF; gsub(/[^0-9]/,"",n); print n+0; exit}')
        purge_p=$(printf '%s\n' "$vm" | awk '/^Pages purgeable/    {n=$NF; gsub(/[^0-9]/,"",n); print n+0; exit}')
        free_p=${free_p:-0}; file_p=${file_p:-0}; purge_p=${purge_p:-0}
        avail=$(( (free_p + file_p + purge_p) * pagesize ))
        used=$(( total - avail ))
        [ "$used" -lt 0 ] && used=0
        used_h=$(_human_bytes "$used")
        total_h=$(_human_bytes "$total")
        [ "${total:-0}" -gt 0 ] && mac_pct=$(( used * 100 / total ))
    else
        # Linux: `free -h` outputs "9.7Gi" / "31Gi". Localized builds may print
        # decimal comma -> normalize to dot. Strip trailing "i" for tighter width.
        # Regex "/^Mem/" (no colon) tolerates busybox/procps variants.
        local mem_line; mem_line=$(free -h 2>/dev/null | awk '/^Mem/ {gsub(",","."); print; exit}')
        used_h=$(echo "$mem_line" | awk '{print $3}' | sed 's/i$//')
        total_h=$(echo "$mem_line" | awk '{print $2}' | sed 's/i$//')
        # Fallback if `free -h` unavailable (rare) — try `free -m` and format
        if [ -z "$used_h" ] || [ -z "$total_h" ]; then
            mem_line=$(free -m 2>/dev/null | awk '/^Mem/ {print; exit}')
            local used_mb total_mb
            used_mb=$(echo "$mem_line" | awk '{print $3}')
            total_mb=$(echo "$mem_line" | awk '{print $2}')
            [ -n "$used_mb" ]  && used_h=$(_human_bytes  "$((used_mb  * 1024 * 1024))")
            [ -n "$total_mb" ] && total_h=$(_human_bytes "$((total_mb * 1024 * 1024))")
        fi
    fi
    # Color by pressure: green when plenty free, yellow/orange/red as it fills.
    # Compute used% from raw bytes when available; else fall back to SUBFG.
    local color="$SUBFG" pct=""
    if [ "$OS" = "linux" ]; then
        pct=$(free 2>/dev/null | awk '/^Mem/ {if ($2>0) printf "%d", ($3*100)/$2}')
    else
        pct="$mac_pct"
    fi
    if [ -n "$pct" ]; then
        if   [ "$pct" -lt 40 ]; then color="$GOOD"
        elif [ "$pct" -lt 70 ]; then color="$WARN"
        elif [ "$pct" -lt 90 ]; then color="$WARN2"
        else                         color="$DANGER"
        fi
    fi
    printf "#[fg=%s]%s/%s" "$color" "${used_h:-?}" "${total_h:-?}"
}

# CPU temperature (optional; may be unavailable)
function cpu_temp() {
    local cur_temp=""
    if [ "$OS" = "macos" ]; then
        if command -v osx-cpu-temp >/dev/null 2>&1; then
            cur_temp=$(osx-cpu-temp 2>/dev/null | grep -oE '[0-9]+\.[0-9]+' | head -n1)
            # osx-cpu-temp returns 0.0 on Apple Silicon (SMC keys absent).
            # Treat as unavailable so widget shows "--" instead of misleading 0°C.
            case "$cur_temp" in 0|0.0|0.00) cur_temp="" ;; esac
        fi
    else
        if command -v sensors >/dev/null 2>&1; then
            cur_temp=$(sensors 2>/dev/null | grep '°C' | grep -E 'temp|Tctl|Package' | head -n 1 \
                | grep -oE '\+?[0-9]+\.[0-9]+°C' | head -n1 | tr -d '+°C')
        fi
    fi
    # Sensor unavailable -> muted placeholder
    if [ -z "$cur_temp" ]; then
        printf "#[fg=%s]%s°C" "$MUTED" "--"
        return
    fi

    # Threshold color (7 tiers matching CPU load for visual consistency)
    local temp color; temp=${cur_temp%.*}
    if   [[ $temp -lt 30 ]] ; then color="$GOOD"
    elif [[ $temp -lt 40 ]] ; then color="$COOL"
    elif [[ $temp -lt 50 ]] ; then color="$WARN"
    elif [[ $temp -lt 60 ]] ; then color="$WARN"
    elif [[ $temp -lt 70 ]] ; then color="$WARN2"
    elif [[ $temp -lt 80 ]] ; then color="$WARN2"
    else                           color="$DANGER"
    fi
    # Fixed width: "%4s°C" -> e.g. "19.3°C" (6 cols)
    printf "#[fg=%s]%s°C" "$color" "$cur_temp"
}

# Disk (df is cross-platform)
function get_disk_space(){
    local space free_space total_space percentage_used percentage_used_num print_data
    space=$(df -h / 2>/dev/null | tail -n 1 | tr -s ' ')
    free_space=$(echo "${space}" | awk '{print $4}')
    total_space=$(echo "${space}" | awk '{print $2}')
    percentage_used=$(echo "${space}" | awk '{print $5}')
    percentage_used_num=${percentage_used%\%}
    # 4 tiers: green -> yellow -> orange -> red at 40/60/85%
    local color
    if   [[ ${percentage_used_num:-0} -lt 40 ]] ; then color="$GOOD"
    elif [[ ${percentage_used_num:-0} -lt 60 ]] ; then color="$WARN"
    elif [[ ${percentage_used_num:-0} -lt 85 ]] ; then color="$WARN2"
    else                                                color="$DANGER"
    fi
    printf "#[fg=%s]F:%s" "$color" "$free_space"
}

# Speed formatting: tight max 4 chars ("999B", "9.9K", "99M", "9.9G")
function get_speed(){
    local l_speed=${1:-0}
    awk -v b="$l_speed" 'BEGIN {
        if      (b < 1000)         printf "%dB", b
        else if (b < 10000)        printf "%.1fK", b/1000
        else if (b < 1000000)      printf "%dK",  b/1000
        else if (b < 10000000)     printf "%.1fM", b/1000000
        else if (b < 1000000000)   printf "%dM",  b/1000000
        else if (b < 10000000000)  printf "%.1fG", b/1000000000
        else                       printf "%dG",  b/1000000000
    }'
}

# Tight bytes formatter used by memory on macOS: "9.9G", "999M", "30G"
function _human_bytes(){
    awk -v b="${1:-0}" 'BEGIN {
        s="B K M G T"; split(s,a," "); i=1
        while (b>=1024 && i<5) { b/=1024; i++ }
        if (b<10 && i>1) printf "%.1f%s", b, a[i]
        else             printf "%d%s",   b, a[i]
    }'
}

# Network sample: single 1s window, returns "rx_delta tx_delta"
function net_sample(){
    local iface old_rx old_tx new_rx new_tx
    iface=$(interface_name)
    if [ -z "$iface" ]; then echo "0 0"; return; fi

    if [ "$OS" = "macos" ]; then
        # netstat -ibn columns: Name Mtu Network Address Ipkts Ierrs Ibytes Opkts Oerrs Obytes ...
        read -r old_rx old_tx < <(netstat -ibn 2>/dev/null | awk -v i="$iface" '$1==i && $1!~/\*/ {print $7, $10; exit}')
        sleep 1
        read -r new_rx new_tx < <(netstat -ibn 2>/dev/null | awk -v i="$iface" '$1==i && $1!~/\*/ {print $7, $10; exit}')
    else
        old_rx=$(cat "/sys/class/net/${iface}/statistics/rx_bytes" 2>/dev/null)
        old_tx=$(cat "/sys/class/net/${iface}/statistics/tx_bytes" 2>/dev/null)
        sleep 1
        new_rx=$(cat "/sys/class/net/${iface}/statistics/rx_bytes" 2>/dev/null)
        new_tx=$(cat "/sys/class/net/${iface}/statistics/tx_bytes" 2>/dev/null)
    fi
    old_rx=${old_rx:-0}; old_tx=${old_tx:-0}; new_rx=${new_rx:-0}; new_tx=${new_tx:-0}
    echo "$((new_rx - old_rx)) $((new_tx - old_tx))"
}

function net_traffic(){
    local rx tx up_h down_h
    read -r rx tx < <(net_sample)
    up_h=$(get_speed "${tx:-0}")
    down_h=$(get_speed "${rx:-0}")
    printf "#[fg=%s]↖ %4s ↘ %4s" "$COOL" "$up_h" "$down_h"
}

function battery_level(){
    echo -n ""
}

# ============================================================================
#  STATUS BAR ASSEMBLY
#
#  Powerline-style segments joined by arrow glyphs. Each widget carries its
#  own foreground color; the surrounding segment sets the background so bg
#  transitions render cleanly through the arrows.
#
#  Layout:
#    LEFT   [ session ] > [ ip ] > [ disk ][ net ]
#    RIGHT           [ mem ][ temp ][ cpu ] < [ hostname ] <
#
#    ">" = right-pointing powerline arrow (RIGHT_ARROW)
#    "<" = left-pointing  powerline arrow (LEFT_ARROW)
#
#  Widgets emit fixed-width content with no trailing space; the assembler
#  inserts exactly ONE space between adjacent widgets.
# ============================================================================

function left_status(){
    local ip_val disk_val net_val
    ip_val=$(local_ip)
    disk_val=$(get_disk_space)
    net_val=$(net_traffic)

    # 1) Session segment  -> ACCENT background, dark text, bold
    printf '#[fg=%s,bg=%s,bold] #S ' "$ACCENT_FG" "$ACCENT"
    # arrow: ACCENT -> SURFACE
    printf '#[fg=%s,bg=%s,nobold,nounderscore,noitalics]%s' "$ACCENT" "$SURFACE" "$RIGHT_ARROW"

    # 2) IP segment  -> SURFACE background (flexible width, IP does not change)
    printf '#[fg=%s,bg=%s] %s ' "$FG" "$SURFACE" "$ip_val"
    # arrow: SURFACE -> BG
    printf '#[fg=%s,bg=%s,nobold,nounderscore,noitalics]%s' "$SURFACE" "$BG" "$RIGHT_ARROW"

    # 3) Disk + net stats  -> BG (widgets embed their own fg color)
    printf '#[bg=%s] %s %s ' "$BG" "$disk_val" "$net_val"
    echo
}

function right_status(){
    local mem_val temp_val cpu_val
    mem_val=$(memory_stats)
    temp_val=$(cpu_temp)
    cpu_val=$(cpu_usage)

    # 1) Mem + temp + cpu  -> BG (widgets embed own fg colors)
    printf '#[bg=%s] %s  %s  %s ' "$BG" "$mem_val" "$temp_val" "$cpu_val"

    # arrow: BG -> SURFACE
    printf '#[fg=%s,bg=%s,nobold,nounderscore,noitalics]%s' "$SURFACE" "$BG" "$LEFT_ARROW"

    # 2) Hostname segment  -> SURFACE background
    printf '#[fg=%s,bg=%s] #H ' "$FG" "$SURFACE"

    # arrow: SURFACE -> ACCENT (visual bookend mirroring session bg on left)
    printf '#[fg=%s,bg=%s,nobold,nounderscore,noitalics]%s' "$ACCENT" "$SURFACE" "$LEFT_ARROW"

    # Bookend: small accent block on the far right for visual balance
    printf '#[fg=%s,bg=%s,bold] ' "$ACCENT_FG" "$ACCENT"
    echo
}

function middle_format_active(){
    str=""
    str+="#[fg=${MIDDLE_BAR_ACT_CLR},bg=${MIDDLE_BAR_CLR},nobold,nounderscore,noitalics]${LEFT_ARROW}"
    str+="#[fg=${MIDDLE_BAR_ACT_FNT},bg=${MIDDLE_BAR_ACT_CLR},bold] #I #{?window_zoomed_flag,⌕ ,}#W#{?window_zoomed_flag, ⌕,} "
    str+="#[fg=${MIDDLE_BAR_ACT_CLR},bg=${MIDDLE_BAR_CLR},nobold,nounderscore,noitalics]${RIGHT_ARROW}"
    echo "$str"
}

function middle_format(){
    str=""
    str+="#[fg=${MIDDLE_BAR_FNT},bg=${MIDDLE_BAR_CLR}] #I #W "
    echo "$str"
}

# Print memory pieces + widget output. Run manually to diagnose macOS mismatches.
function mem_debug(){
    echo "OS: $OS"
    if [ "$OS" = "macos" ]; then
        echo "sysctl hw.memsize  = $(sysctl -n hw.memsize)"
        echo "sysctl hw.pagesize = $(sysctl -n hw.pagesize)"
        echo "--- vm_stat (relevant lines) ---"
        vm_stat | awk '/^Pages free|^File-backed pages|^Pages purgeable|^Pages active|^Pages wired down|^Pages occupied by compressor|^Anonymous pages/'
        echo "--- top PhysMem ---"
        top -l 1 -n 0 -s 0 2>/dev/null | awk '/^PhysMem:/'
    else
        echo "--- free ---"
        free -h
    fi
    echo "--- widget output ---"
    memory_stats; echo
}


#------------------------------------------------------------------------------------

while :
do
    case "$1" in
        -h | --help)                helpMenu ;                  exit 0;;
        -l | --left)                left_status;                exit 0;;
        -m | --middle)              middle_format;              exit 0;;
        -M | --middle-active)       middle_format_active;       exit 0;;
        -r | --right)               right_status;               exit 0;;
        -s | --setup)               setup_on_system;            exit 0;;
        --net-debug)                net_debug;                  exit 0;;
        --mem-debug)                mem_debug;                  exit 0;;

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

