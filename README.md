# tmux-monitor-theme ![MIT license](https://img.shields.io/github/license/CSpyridakis/tmux-monitor-theme.svg?style=plastic) ![Size](https://img.shields.io/github/repo-size/CSpyridakis/tmux-monitor-theme.svg?style=plastic)


This repo contains a useful - despite its minimalism - tmux theme.

Theme's screenshot

![image](doc/example.png)

### INSTALLATION
To install it, copy `.tmux.conf` and `tmux-functions.sh` files to your `${HOME}` directory. `INSTALL` script automates this process and is possible by executing `INSTALL -h` to see all of its available options.

### STATUS BAR
The status bar provides fast access to some system information. From left to right you will find:
* Tmux session’s name
* Local IP address (actually the first one that appears on `hostname -I` command)
* Network upload/download traffic statistics
* Panes’ names
* Available Ram/Total ram
* CPU temperature (use psensors)
* CPU load
* Current user name

## IMPORTANT
I use `zsh` with `oh-my-zsh` installed and `agnoster` theme on top of it. So if you want your terminal to look like the image above run also 'INSTALL -z' or execute first the following commands.
```
sudo apt-get -y install zsh
sudo apt-get -y install fonts-powerline
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
chsh -s $(which zsh)  
```
Then change in your `~/.zshrc` the theme's name to `ZSH_THEME="agnoster"`.
