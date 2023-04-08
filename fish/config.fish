### Colors
# RosePine
set -l foreground e0def4
set -l selectio  c4a7e7
set -l comment 908caa
set -l red eb6f92
set -l orange f6c177
set -l yellow ebbcba
set -l green 9ece6a
set -l purple c4a7e7
set -l cyan 9ccfd8
set -l pink ecaff2

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $gray
set -g fish_pager_color_prefix $mauve
set -g fish_pager_color_completion $peach
set -g fish_pager_color_description $gray

set -g man_blink -o $teal
set -g man_bold -o $pink
set -g man_standout -b $gray
set -g man_underline -u $blue



set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

if status --is-interactive
  starship init fish | source
  zoxide init fish --cmd cd | source
  source ~/.local/share/omf/pkg/colorman/init.fish
  thefuck --alias | source
end

## Functions
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
  builtin history --show-time='%F %T '
end

function backup --argument filename
  cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
  set count (count $argv | tr -d \n)
  if test "$count" = 2; and test -d "$argv[1]"
	  set from (echo $argv[1] | trim-right /)
	  set to (echo $argv[2])
    command cp -r $from $to
  else
     command cp $argv
  end
end

alias mkd="mkdir"

# Make dir, cd to it
function mkcd
	mkdir $argv[1]
	cd $argv[1]
end

# Push all changes after commiting them with a message
function gpush
	git add .
	git commit -m $argv[1]
	git push -u origin main
end

# Locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Default programs
export EDITOR="nvim"
export TERM='xterm-kitty'
export BROWSER="firefox"

# cargo-mommy
export CARGO_MOMMYS_LITTLE="girl"
export CARGO_MOMMYS_PRONOUNS="her"
export CARGO_MOMMYS_ROLES="mommy"


## Useful aliases
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
abbr -a -g d 'dirs'
abbr -a -g h 'cd $HOME'

alias ip="ip -color"


# Common use
alias grubup="sudo update-grub"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -xvf '
alias wget='wget -c '
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                                   # Hardware Info

# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"


## Lumi!
set -p PATH $HOME/.local/share/ponyup/bin
set -p PATH $HOME/.local/bin
set -p PATH $HOME/go/bin
set -p PATH $HOME/.emacs.d/bin
set -p PATH $HOME/.config/emacs/bin
set -p PATH $HOME/.local/share/coursier/bin
set -p PATH $HOME/.cabal/bin
set -p PATH $HOME/.ghcup/bin
set -p PATH $HOME/.cargo/bin/

set XDG_CURRENT_DESKTOP Hyprland
set XDG_SESSION_TYPE    wayland
set XDG_SESSION_DESKTOP Hyprland

alias ivy="rlwrap ivy"
alias luajit="rlwrap luajit"
alias rakudocli="rlwrap rakudo"

alias icat="kitty +kitten icat"

abbr -a -g yay "paru"



# Generate a random, 36-charactered password
abbr -a -g genpass "pwgen -c -n -y -s 32 | head"

abbr -a -g cargo "cargo mommy"

set MOZ_ENABLE_WAYLAND 1
set CHROME_EXECUTABLE /usr/bin/chromium

# pnpm
set -gx PNPM_HOME "/home/lumi/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end

