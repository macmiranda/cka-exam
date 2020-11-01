#!/bin/bash

sudo apt-get update && sudo apt-get install -y zsh tmux git vim curl

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

patch ~/.zshrc <<EOF
--- /home/ubuntu/.zshrc 2020-10-31 23:16:33.041488134 +0100
+++ zshrc       2020-10-31 23:23:26.377539797 +0100
@@ -17,7 +17,7 @@
 # ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

 # Uncomment the following line to use case-sensitive completion.
-# CASE_SENSITIVE="true"
+CASE_SENSITIVE="true"

 # Uncomment the following line to use hyphen-insensitive completion.
 # Case-sensitive completion must be off. _ and - will be interchangeable.
@@ -68,7 +68,7 @@
 # Custom plugins may be added to $ZSH_CUSTOM/plugins/
 # Example format: plugins=(rails git textmate ruby lighthouse)
 # Add wisely, as too many plugins slow down shell startup.
-plugins=(git)
+plugins=(git kubectl)

 source $ZSH/oh-my-zsh.sh
EOF

sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update

echo "export EDITOR=/usr/bin/vim" >> ~/.zshrc

# zsh
