# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A tmux theme with a system-monitor status bar. Ships two files that live in `$HOME`:

- `~/.tmux.conf` — theme + keybindings
- `~/.tmux-functions.sh` — bash script that renders every status-bar segment

The repo copies of these are `.tmux.conf` and `tmux-functions.sh` at the root. The `INSTALL` script copies or symlinks them into place and can also install missing dependencies.

## Common commands

Installation / requirements (run from repo root):

```bash
./INSTALL -k        # --check: probe target for required tools + Nerd Font
./INSTALL -r        # --requirements: check, then install missing packages
./INSTALL -l        # --link-both: symlink .tmux.conf + tmux-functions.sh into $HOME
./INSTALL -c        # --copy-both: same, but copy instead of symlink
./INSTALL --force   # bypass hard-requirement gate
./INSTALL -z        # install zsh + oh-my-zsh agnoster (Linux/apt only)
```

`INSTALL -T` / `-F` link a single file; `-t` / `-f` copy a single file. Full list: `./INSTALL -h`.

Reload tmux config after edits:

```bash
tmux source-file ~/.tmux.conf   # or: prefix + r
```

Run the status-bar script directly to inspect widget output (what tmux will render):

```bash
./tmux-functions.sh -l          # left status
./tmux-functions.sh -r          # right status
./tmux-functions.sh -m          # inactive window label
./tmux-functions.sh -M          # active window label
./tmux-functions.sh --net-debug # network interface selection + sample
./tmux-functions.sh --mem-debug # memory pieces + widget output
```

No build, no test suite, no linter configured.

## Architecture

### How the status bar renders

`.tmux.conf` invokes the bash script via tmux's `#(...)` format:

- `status-left`  → `tmux-functions.sh -l` → `left_status`
- `status-right` → `tmux-functions.sh -r` → `right_status`
- `window-status-format` → `-m` → `middle_format` (inactive tab)
- `window-status-current-format` → `-M` → `middle_format_active` (active tab)

`status-interval` is 1s, but `cpu_usage` and `net_sample` each sleep 1s internally — tmux still runs them serialized per interval. Do not lower the interval below the widget sleep or draws will race.

### Powerline segment assembly (`tmux-functions.sh`)

Each widget (`cpu_usage`, `memory_stats`, `cpu_temp`, `get_disk_space`, `net_traffic`, `local_ip`) prints a **fixed-width** string that already embeds its own `#[fg=...]` color marker. The `left_status` / `right_status` assemblers then:

1. Set the segment background with `#[bg=...]`
2. Insert powerline arrow glyphs (`RIGHT_ARROW` / `LEFT_ARROW`) between segments to transition bg colors
3. Add exactly one space between adjacent widgets

Widths are fixed on purpose so the bar does not reflow as values change (1 vs 2 vs 3-digit CPU %, IP string, etc.). If you edit a widget, keep the width contract or the arrows will visibly jitter.

Arrow glyphs require a Nerd Font. `USE_ARROWS=0` at the top of the script disables them for terminals without one.

### Color palette — two knobs

Colors are centralized so the theme is retunable without touching logic:

- **`.tmux.conf` top block** — panes, borders, active border, message/command bars, clock, pane-border title. Naming convention: `<usage>_<part>_clr`. Anything referenced elsewhere in `.tmux.conf` should read from these vars, not a hard-coded `colourN`.
- **`tmux-functions.sh` top block** — status-bar segments and widget spectrum:
  - `BG`, `SURFACE` — bar background layers
  - `FG`, `SUBFG`, `MUTED` — text tiers
  - `ACCENT` / `ACCENT_FG` — session/host bookends
  - `GOOD`, `COOL`, `WARN`, `WARN2`, `DANGER` — 5-tier spectrum used by CPU load, temp, memory, disk thresholds. Widgets pick from this spectrum, so tweaking one variable retints every threshold-based widget consistently.

Legacy aliases (`THEME_CLR`, `MIDDLE_BAR_*`) are re-exports of the palette kept for backward compatibility — do not add new hard-coded colors, extend the palette instead.

### Cross-platform behavior

`OS` is detected once (`macos` / `linux` / `unknown`) and every widget branches on it: `cpu_usage`, `memory_stats`, `cpu_temp`, `net_sample`, `local_ip`, `interface_name`. When adding a widget, provide both branches or a documented "N/A" fallback (widgets return a `MUTED` placeholder when a source is unavailable — do not throw).

`interface_name` prefers `$TMUX_NET_IFACE` override → physical default-route iface → any default-route iface → first up physical iface. This deliberately skips `tun*`, `docker0`, `veth*`, VirtualBox, etc. so the net widget reflects the real link.

Clipboard bindings in `.tmux.conf` also branch on OS at load time via `if-shell "uname | grep -q Darwin"`.

## README highlights

- Terminal-side setup for the reference look: zsh + oh-my-zsh `agnoster` theme + powerline fonts. `INSTALL -z` automates this on apt-based Linux.
- Screenshot in `doc/example.png`.
