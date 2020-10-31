#!/bin/bash

sudo apt update && sudo apt install -y zsh tmux git vim curl

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo chsh -s /bin/zsh ubuntu 

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cat > ~/.tmux.conf <<EOF
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @resurrect-processes 'ssh psql mysql sqlite3'

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'git@github.com:user/plugin'
# set -g @plugin 'git@bitbucket.com:user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
EOF

zsh
