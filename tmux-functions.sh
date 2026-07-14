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
#  PALETTE — pick a profile below. True hex, tmux downsamples to 256-color
#  automatically on terminals without RGB support.
#  Options: box_dark | nord | dracula | mocha |
#           night | original | forest_dark | rose | kanagawa |
#           solarized_dark | box_light | one_dark | monokai_pro | ayu_dark |
#           light | night_owl | catppuccin_latte | solarized_light |
#           night_storm | palenight | material_ocean | horizon | zenburn |
#           synthwave | oxocarbon | melange
# ============================================================================
THEME="original"

case "$THEME" in
    nord)
        BG="#2e3440"; SURFACE="#3b4252"; FG="#eceff4"; SUBFG="#d8dee9"
        ACCENT="#88c0d0"; ACCENT_FG="#2e3440"
        GOOD="#a3be8c"; COOL="#8fbcbb"; WARN="#ebcb8b"; WARN2="#d08770"
        DANGER="#bf616a"; MUTED="#4c566a"
        ;;
    dracula)
        BG="#282a36"; SURFACE="#44475a"; FG="#f8f8f2"; SUBFG="#6272a4"
        ACCENT="#bd93f9"; ACCENT_FG="#282a36"
        GOOD="#50fa7b"; COOL="#8be9fd"; WARN="#f1fa8c"; WARN2="#ffb86c"
        DANGER="#ff5555"; MUTED="#6272a4"
        ;;
    mocha)
        BG="#1e1e2e"; SURFACE="#313244"; FG="#cdd6f4"; SUBFG="#bac2de"
        ACCENT="#89b4fa"; ACCENT_FG="#1e1e2e"
        GOOD="#a6e3a1"; COOL="#94e2d5"; WARN="#f9e2af"; WARN2="#fab387"
        DANGER="#f38ba8"; MUTED="#6c7086"
        ;;
    night)
        BG="#1a1b26"; SURFACE="#292e42"; FG="#c0caf5"; SUBFG="#a9b1d6"
        ACCENT="#7aa2f7"; ACCENT_FG="#1a1b26"
        GOOD="#9ece6a"; COOL="#7dcfff"; WARN="#e0af68"; WARN2="#ff9e64"
        DANGER="#f7768e"; MUTED="#565f89"
        ;;
    original)
        BG="#262626"; SURFACE="#3a3a3a"; FG="#ffffff"; SUBFG="#c6c6c6"
        ACCENT="#00afff"; ACCENT_FG="#080808"
        GOOD="#00d75f"; COOL="#00ffff"; WARN="#ffd700"; WARN2="#ff8700"
        DANGER="#ff0000"; MUTED="#808080"
        ;;
    forest_dark)
        BG="#2d353b"; SURFACE="#343f44"; FG="#d3c6aa"; SUBFG="#9da9a0"
        ACCENT="#83c092"; ACCENT_FG="#2d353b"
        GOOD="#a7c080"; COOL="#7fbbb3"; WARN="#dbbc7f"; WARN2="#e69875"
        DANGER="#e67e80"; MUTED="#859289"
        ;;
    rose)
        BG="#191724"; SURFACE="#26233a"; FG="#e0def4"; SUBFG="#908caa"
        ACCENT="#c4a7e7"; ACCENT_FG="#191724"
        GOOD="#9ccfd8"; COOL="#31748f"; WARN="#f6c177"; WARN2="#ebbcba"
        DANGER="#eb6f92"; MUTED="#6e6a86"
        ;;
    kanagawa)
        BG="#1f1f28"; SURFACE="#2a2a37"; FG="#dcd7ba"; SUBFG="#a3a0a8"
        ACCENT="#7e9cd8"; ACCENT_FG="#1f1f28"
        GOOD="#98bb6c"; COOL="#7aa89f"; WARN="#e6c384"; WARN2="#ffa066"
        DANGER="#ff5d62"; MUTED="#727169"
        ;;
    solarized_dark)
        BG="#002b36"; SURFACE="#073642"; FG="#93a1a1"; SUBFG="#839496"
        ACCENT="#268bd2"; ACCENT_FG="#002b36"
        GOOD="#859900"; COOL="#2aa198"; WARN="#b58900"; WARN2="#cb4b16"
        DANGER="#dc322f"; MUTED="#586e75"
        ;;
    box_light)
        BG="#fbf1c7"; SURFACE="#ebdbb2"; FG="#3c3836"; SUBFG="#504945"
        ACCENT="#076678"; ACCENT_FG="#fbf1c7"
        GOOD="#79740e"; COOL="#427b58"; WARN="#b57614"; WARN2="#af3a03"
        DANGER="#9d0006"; MUTED="#7c6f64"
        ;;
    one_dark)
        BG="#282c34"; SURFACE="#3b4048"; FG="#abb2bf"; SUBFG="#9299a6"
        ACCENT="#61afef"; ACCENT_FG="#282c34"
        GOOD="#98c379"; COOL="#56b6c2"; WARN="#e5c07b"; WARN2="#d19a66"
        DANGER="#e06c75"; MUTED="#5c6370"
        ;;
    monokai_pro)
        BG="#2d2a2e"; SURFACE="#403e41"; FG="#fcfcfa"; SUBFG="#c1c0c0"
        ACCENT="#ab9df2"; ACCENT_FG="#2d2a2e"
        GOOD="#a9dc76"; COOL="#78dce8"; WARN="#ffd866"; WARN2="#fc9867"
        DANGER="#ff6188"; MUTED="#727072"
        ;;
    ayu_dark)
        BG="#0a0e14"; SURFACE="#1f2430"; FG="#b3b1ad"; SUBFG="#8a8986"
        ACCENT="#ffb454"; ACCENT_FG="#0a0e14"
        GOOD="#c2d94c"; COOL="#95e6cb"; WARN="#ffb454"; WARN2="#ff8f40"
        DANGER="#f07178"; MUTED="#4d5566"
        ;;
    light)
        BG="#ffffff"; SURFACE="#eaeef2"; FG="#24292f"; SUBFG="#424a53"
        ACCENT="#0969da"; ACCENT_FG="#ffffff"
        GOOD="#1a7f37"; COOL="#1b7c83"; WARN="#9a6700"; WARN2="#bc4c00"
        DANGER="#cf222e"; MUTED="#57606a"
        ;;
    night_owl)
        BG="#011627"; SURFACE="#0b2942"; FG="#d6deeb"; SUBFG="#8badc1"
        ACCENT="#82aaff"; ACCENT_FG="#011627"
        GOOD="#addb67"; COOL="#7fdbca"; WARN="#ffeb95"; WARN2="#f78c6c"
        DANGER="#ef5350"; MUTED="#637777"
        ;;
    catppuccin_latte)
        BG="#eff1f5"; SURFACE="#ccd0da"; FG="#4c4f69"; SUBFG="#5c5f77"
        ACCENT="#1e66f5"; ACCENT_FG="#eff1f5"
        GOOD="#40a02b"; COOL="#179299"; WARN="#df8e1d"; WARN2="#fe640b"
        DANGER="#d20f39"; MUTED="#9ca0b0"
        ;;
    solarized_light)
        BG="#fdf6e3"; SURFACE="#eee8d5"; FG="#586e75"; SUBFG="#657b83"
        ACCENT="#268bd2"; ACCENT_FG="#fdf6e3"
        GOOD="#859900"; COOL="#2aa198"; WARN="#b58900"; WARN2="#cb4b16"
        DANGER="#dc322f"; MUTED="#93a1a1"
        ;;
    night_storm)
        BG="#24283b"; SURFACE="#2f334d"; FG="#c0caf5"; SUBFG="#a9b1d6"
        ACCENT="#7aa2f7"; ACCENT_FG="#24283b"
        GOOD="#9ece6a"; COOL="#7dcfff"; WARN="#e0af68"; WARN2="#ff9e64"
        DANGER="#f7768e"; MUTED="#565f89"
        ;;
    palenight)
        BG="#292d3e"; SURFACE="#3a3f58"; FG="#a6accd"; SUBFG="#8f93a8"
        ACCENT="#c792ea"; ACCENT_FG="#292d3e"
        GOOD="#c3e88d"; COOL="#89ddff"; WARN="#ffcb6b"; WARN2="#f78c6c"
        DANGER="#ff5370"; MUTED="#676e95"
        ;;
    material_ocean)
        BG="#0f111a"; SURFACE="#1f2233"; FG="#a6accd"; SUBFG="#8f93a8"
        ACCENT="#82aaff"; ACCENT_FG="#0f111a"
        GOOD="#c3e88d"; COOL="#89ddff"; WARN="#ffcb6b"; WARN2="#f78c6c"
        DANGER="#ff5370"; MUTED="#464b5d"
        ;;
    horizon)
        BG="#1c1e26"; SURFACE="#2e303e"; FG="#d5d8da"; SUBFG="#b0b3b8"
        ACCENT="#e95678"; ACCENT_FG="#1c1e26"
        GOOD="#29d398"; COOL="#59e1e3"; WARN="#fab795"; WARN2="#f09383"
        DANGER="#f43e5c"; MUTED="#6c6f93"
        ;;
    zenburn)
        BG="#3f3f3f"; SURFACE="#4f4f4f"; FG="#dcdccc"; SUBFG="#c0c0b0"
        ACCENT="#8cd0d3"; ACCENT_FG="#2b2b2b"
        GOOD="#7f9f7f"; COOL="#93e0e3"; WARN="#f0dfaf"; WARN2="#dfaf8f"
        DANGER="#cc9393"; MUTED="#709080"
        ;;
    synthwave)
        BG="#262335"; SURFACE="#34294f"; FG="#f0eff1"; SUBFG="#b6b1c8"
        ACCENT="#ff7edb"; ACCENT_FG="#262335"
        GOOD="#72f1b8"; COOL="#36f9f6"; WARN="#fede5d"; WARN2="#ff8b39"
        DANGER="#fe4450"; MUTED="#848bbd"
        ;;
    oxocarbon)
        BG="#161616"; SURFACE="#262626"; FG="#f2f4f8"; SUBFG="#c6c6c6"
        ACCENT="#78a9ff"; ACCENT_FG="#161616"
        GOOD="#42be65"; COOL="#3ddbd9"; WARN="#d2a106"; WARN2="#ff832b"
        DANGER="#ee5396"; MUTED="#525252"
        ;;
    melange)
        BG="#292522"; SURFACE="#34302c"; FG="#ece1d7"; SUBFG="#c1a78e"
        ACCENT="#89b3b6"; ACCENT_FG="#292522"
        GOOD="#85b695"; COOL="#7d9b9e"; WARN="#ebc06d"; WARN2="#d9a072"
        DANGER="#d47766"; MUTED="#867462"
        ;;
    box_dark|*)
        BG="#282828"; SURFACE="#3c3836"; FG="#d4be98"; SUBFG="#a89984"
        ACCENT="#7daea3"; ACCENT_FG="#1d2021"
        GOOD="#a9b665"; COOL="#89b482"; WARN="#d8a657"; WARN2="#e78a4e"
        DANGER="#ea6962"; MUTED="#928374"
        ;;
esac

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

