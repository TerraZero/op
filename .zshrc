# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

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

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
	
alias sha="cat ~/.zshrc | grep \"^alias \""
alias shpid="ps -ax | grep"
alias shpidall="ps -ax"
alias killpid="kill -9"
alias gw="grunt watch"

alias ea="gedit ~/.zshrc && source ~/.zshrc"
alias ephp="sudo gedit /etc/php5/apache2/php.ini && sudo service apache2 restart"
alias c="clear"
alias myip="ifconfig | grep 'inet addr:'"
alias ephp="sudo subl /etc/php5/apache2/php.ini"
alias arestart="sudo service apache2 restart"

alias dl="cd ~/Downloads"
# alias dport="sudo ./drupal_import.sh"
alias sk="cd ~/Skype"
alias pro="cd ~/projects && cd"
alias th="cd sites/all/themes && cd"
alias pros="la ~/projects"
alias jpro="cd ~/eclipsesource && cd"

alias gs="git status"
alias gp="git pull"
alias ga="git add -A"
alias grs="git add -A && git commit -m 'refresh css or tpls'"
alias gadd="git add -A && git commit -m"
alias gc="git commit -m"
alias gca="git commit -am"
alias gpp="git pull && git push"
alias gm="git merge"
alias merge="git merge"
alias gb="git checkout"
alias branch="git checkout"
alias grindex="git rm --cached"
alias remove_file_index="git rm --cached"
alias p="git push"
alias clone="git clone"
alias gn="git checkout -b"
alias init_branch="git push --set-upstream origin"
alias remove_branch="git push origin --delete"
alias gr="git branch -D"
alias gbl="git show-branch --list"
alias gblo="git show-branch --list --remotes"

alias dinit="cp sites/default/default.settings.php sites/default/settings.php && cp ~/.htaccess ./.htaccess"
alias din="drush dl"
alias den="drush en"
alias dis="drush dis"
alias dun="drush pm-uninstall"
alias dcc="drush cc all"
alias dlm="drush pm-list --type=Module --status=enabled"
alias dperma="drush rap 'anonymous user'"
alias droles="drush role-list"
alias dlogin="drush uli"

alias nlist="npm list --depth=0"
alias nin="npm install"
alias nun="npm remove"
