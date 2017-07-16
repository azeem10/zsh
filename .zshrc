# -------------------------------------------------------------------------------
#   @author: Muhammad Azeem
#   @license: MIT License (MIT)
# -------------------------------------------------------------------------------

# -----------------------
#    Zsh Configuration
# -----------------------

# File Permissions
umask 077

# Add MySQL to Path
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/mysql/bin

# Emacs Key Bindings
bindkey -e

# -----------------------
#       Navigation
# -----------------------

# Aliases
alias ls='ls -lah'                      # Long Listing
alias cdd='cd .. && ls -lah'            # Move to Parent Directory and List Contents
alias cddd='cd ..'                      # Move to Parent Directory
alias cll='cd $OLDPWD && ls -lah'       # Return to Previous Directory and List Contents
alias clll='cd $OLDPWD'                 # Return to Previous Directory

# Functions

# Change Directory and List Contents
function cl () {
    cd $1 && ls -lah
}

# Enable Zsh Autocompletion
autoload -Uz compinit && compinit

# -----------------------
#         Design
# -----------------------

# Add Color to Zsh
export CLICOLOR=1
export LSCOLORS=bxcxaddxabdeedBcBdfdfh

# Prompt
autoload -U colors && colors
PROMPT="%{$fg[blue]%}%n%{$reset_color%} %{$fg[red]%}@%{$reset_color%} %{$fg[yellow]%}[%c]%{$reset_color%} %{$fg[green]%}%#:%{$reset_color%} "
RPROMPT="%{$fg[yellow]%}%2/%{$reset_color%}"

# -----------------------
#        History
# -----------------------

# History Options
setopt HIST_IGNORE_ALL_DUPS             # Ignores Duplicates When Writing Out to History
setopt HIST_IGNORE_SPACE                # Excludes Commands Entered with a Trailing Space from History
setopt HIST_VERIFY                      # Reviews History Substitution Result before Executing

# History Navigation
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey '^[[A' history-beginning-search-backward-end
bindkey '^[[B' history-beginning-search-forward-end

zstyle ':completion:*' menu select      # Navigate Through Autocomplete Options

# Remove History Files (Bash, Less, Vim, MySQL, R, R Studio)
history_files=( '.bash_history' '.lesshst' '.viminfo' '.mysql_history' '.Rapp.history' '.Rhistory' )

function nuke () {
    
local count=0

    for i in $history_files; do
        if [ -f /Users/Azeem/$i ]; then
            rm /Users/Azeem/$i
            printf "\n$fg[red]$i trashed.$reset_color"
            ((count++))
        fi
    done
    
    # Remove Additional Line When No Files Exist
    if [[ $count -ge 1 ]]; then
        printf "\n"
    fi

printf "\n$fg[magenta]$count/$#history_files files trashed.$reset_color\n\n"

}
