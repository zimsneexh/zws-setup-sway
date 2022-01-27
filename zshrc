if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx
fi

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v

setopt autocd
setopt interactivecomments
setopt extended_glob

bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey '\e[H' beginning-of-line
bindkey ";5H" beginning-of-line
bindkey '\e[F' end-of-line
bindkey ";5F" end-of-line
bindkey "\e[3~" delete-char

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

echo 1/4: Loading zstyle, compinit...

zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit && compinit

echo 2/4: Initializing dependencies with zplug...

if [[ ! -d ~/.zplug ]];then
    git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug "mafredri/zsh-async", from:github
zplug "lib/completion", from:oh-my-zsh
zplug "themes/agnoster", use:agnoster.zsh, from:oh-my-zsh, as:theme
zplug "zsh-users/zsh-syntax-highlighting", from:github, defer:3
zplug "MichaelAquilina/zsh-you-should-use"
zplug "zsh-users/zsh-autosuggestions", from:github

echo 3/4: Loading zplug dependencies...

zplug load

if ! zplug check --verbose; then
    printf "Install zplug plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

echo 4/4: Setting aliases...

# ================================================================================================
# Aliases
#

# copy to clipboard
alias toclip="wl-copy"

# CLI Music player
alias wtfmusic="mpc rescan && ncmpcpp"
alias music="mpc rescan && ncmpcpp"

# YouTube video using mpv in terminal
alias ytmusic="mpv --no-video"

#cd stuff
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'

#file operations
alias rm='rm -I'
alias mv='mv -i'
alias cp='cp -i'
alias df='df -h'
alias size='du -hs'
alias md='mkdir -p'
alias mkdirs='mkdir -pv'
alias rd='rmdir'
alias vi='nvim'
alias tree='find . -print | sed -e '\''s;[^/]*/;|____;g;s;____|; |;g'\'''

# List
alias ls='ls --color=auto -h --group-directories-first'
alias la='ls --color=auto -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" -F'
alias ll='ls --color=auto -lh --group-directories-first --time-style=+"%d.%m.%Y %H:%M" -F'

# Package management for Archlinux
alias dblock='sudo rm -f /var/lib/pacman/db.lck'
alias update='sudo pacman -Syyu'
alias syncp='sudo pacman -Sy'

# Grep
alias grep='grep --color=auto'
alias g='grep --color=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

# Misc
alias sudo='doas'
alias getprocessname='ps aux | grep'
alias genpw='pwgen -c -n -y 48 1'
alias genpws='pwgen -c -n 48 1'
alias mp3dl='youtube-dl -x --audio-format mp3 --metadata-from-title "%(artist)s - %(title)s" -o "%(title)s.%(ext)s"'
alias free='free -m'
alias h='history'
alias genpws='pwgen -c -n 36 1'
alias q='exit'
alias reload='source ~/.zshrc'
alias nv='nvim'
alias vim='nvim'
alias :q="quit"

#append doas before rebooting
if [ $UID -ne 0 ]; then
         alias reboot='doas reboot'
fi

# # ex - archive extractor
# # usage: ex <file>
ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.gz)	   tar xzf $1   ;;
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.jar)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
   fi
}

#settings environment variables..
export TERM=xterm-256color
export EDITOR=/usr/bin/nvim # TODO
export BROWSER=/usr/bin/qutebrowser # TODO
export PAGER=/usr/bin/vimpager # TODO
export LANG=en_US.utf8
export SCRIPT_DIR=$HOME/scripts
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=setting'

# clear screen before showing shell prompt
clear
