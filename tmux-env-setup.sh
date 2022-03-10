#!/bin/bash
SESSION="Dummy"

# Create session
tmux -2 new-session -d -s $SESSION

# Create panes
tmux split-window -h
tmux select-pane -t 0
tmux split-window -v

# ----------------------------------------
# Actions
source_develop="clear"   # Source to every pane local development 

# 0
tmux select-pane -t 0
tmux resize-pane -L 50
tmux send-keys "${source_develop}" C-m
tmux send-keys 'echo "hello"'

# 1
tmux select-pane -t 1
tmux send-keys "${source_develop}" C-m
tmux send-keys 'echo "hi"'


# ========================================
# ========================================

# Select default window
tmux select-window -t $SESSION

# Attach session to terminal
tmux -2 attach-session -t $SESSION

