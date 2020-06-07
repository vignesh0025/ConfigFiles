source ~/.env_detect.sh

if [ -z "$ENV_WSL" ]|| [ $ENV_WSL -eq "0" ]; then
    compinit
    kitty + complete setup zsh | source /dev/stdin
    source /usr/libexec/z.sh
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/vignesh/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable tmux plugin in zsh
# NOTE: This should be in *vscode settings*
# "terminal.integrated.env.linux": {
#        "TERM_PROGRAM":"vscode"
#    }
if [[ "$TERM_PROGRAM" != "vscode" ]]; then
    ZSH_THEME="agnoster"
    ZSH_TMUX_AUTOSTART="true"
else
    ZSH_THEME="af-magic"
fi

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux)


source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
set noautocd

export EDITOR='nvim'
alias vi='nvim'
alias ls='ls --human-readable'

export EDITOR='/usr/bin/nvim'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/vignesh/.sdkman"
[[ -s "/home/vignesh/.sdkman/bin/sdkman-init.sh" ]] && source "/home/vignesh/.sdkman/bin/sdkman-init.sh"

source /home/vignesh/.config/nvim/plugged/gruvbox/gruvbox_256palette.sh
source ~/PY3/bin/activate

export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden '
export FZF_DEFAULT_OPTS='--preview "bat {}"'

export RIPGREP_CONFIG_PATH='/home/vignesh/ConfigFiles/.ripgreprc'

# export ANDROID_HOME=/home/vignesh/Downloads/android_sdk
# export ANDROID_NDK_ROOT=/home/vignesh/Downloads/android_sdk/ndk-bundle

# My Own Utils
# ripgrep - rg - grep alternative
# z - quick filesystem jumper
# lolcat - alternative to cat
# figlet - BIGG Font Producer > `figlet Vignesh | lolcat`

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Hide username@pc from agnoster theme
prompt_context(){}

if [ -z "$ENV_WSL" ]|| [ $ENV_WSL -eq "0" ]; then
    source /usr/share/fzf/shell/key-bindings.zsh
fi
# Search a file with fzf inside a Tmux pane and then open it in an editor
 fzf_then_open_in_editor() {
   local file=$(fzf-tmux)
   # Open the file if it exists
   if [ -n "$file" ]; then
     # Use the default editor if it's defined, otherwise Vim
     ${EDITOR:-vim} "$file"
   fi
 }
bindkey -s '^V' 'fzf_then_open_in_editor' # Ctrl + ↑

alias drop_cache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
