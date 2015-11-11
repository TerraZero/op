# Path to your oh-my-zsh installation.
export ZSH=/home/terrazero/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bullet-train"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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
ZSH_CUSTOM=~/ZSH/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/terrazero/bin"
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

export TERM="xterm-256color"

# INFO alias
alias sha="cat ~/.zshrc | grep \"^alias \"" #INFO
alias sag="showalias.sh" #INFO
alias shpid="ps -ax | grep" #INFO
alias shpa="ps -ax" #INFO
alias myip="ifconfig | grep 'inet addr:'" #INFO

# GENERAL alias
alias ea="gedit ~/.zshrc && source ~/.zshrc" #GENERAL
alias c="clear" #GENERAL
alias killpid="kill -9" #GENERAL
alias o="opendir.sh" #GENERAL

# PATH alias
alias dl="cd ~/Downloads" #PATH
alias sk="cd ~/Skype" #PATH

# GIT alias
alias gs="git status" #GIT
alias gp="git pull" #GIT
alias ga="git add -A" #GIT
alias grs="git add -A && git commit -m 'refresh css or tpls'" #GIT
alias gadd="git add -A && git commit -m" #GIT
alias gc="git commit -m" #GIT
alias gca="git commit -am" #GIT
alias gpp="git pull && git push" #GIT
alias gm="git merge" #GIT
alias merge="git merge" #GIT
alias gb="git checkout" #GIT
alias grindex="git rm --cached" #GIT
alias remove_file_index="git rm --cached" #GIT
alias p="git push" #GIT
alias gn="git checkout -b" #GIT
alias gr="git branch -D" #GIT
alias remove_branch="git push origin --delete" #GIT
alias gbl="git show-branch --list" #GIT
alias gblo="git show-branch --list --remotes" #GIT

# DRUPAL alias
alias dinit="cp sites/default/default.settings.php sites/default/settings.php && cp ~/.htaccess ./.htaccess" #DRUPAL
alias pro="cd ~/projects && cd" #DRUPAL
alias th="cd sites/all/themes && cd" #DRUPAL
alias opr="openproject.sh" #DRUPAL

# DRUSH alias
alias din="drush dl" #DRUSH
alias den="drush en" #DRUSH
alias dis="drush dis" #DRUSH
alias dun="drush pm-uninstall" #DRUSH
alias dcc="drush cc all" #DRUSH
alias dlm="drush pm-list --type=Module --status=enabled" #DRUSH
alias dperma="drush rap 'anonymous user'" #DRUSH
alias droles="drush role-list" #DRUSH
alias dlogin="drupallogin.sh" #DRUSH

# NODEJS alias
alias nlist="npm list --depth=0" #NODEJS
alias nin="npm install" #NODEJS
alias nun="npm remove" #NODEJS

# SQL alias
alias edb="mysql -u root -e" #SQL
alias ldb="mysql -u root -e 'show databases'" #SQL
alias cdb="dbcommand.sh CREATE" #SQL
alias rdb="dbcommand.sh DROP" #SQL
alias idb="importdb.sh" #SQL
alias shdb="dbshow.sh" #SQL

# SUFFIX defaults
alias -s php="subl" #SUFFIX
alias -s js="subl" #SUFFIX
alias -s ini="subl" #SUFFIX

# BULLET TRAIN
BULLETTRAIN_TIME_SHOW=false
BULLETTRAIN_DIR_BG=white
BULLETTRAIN_DIR_FG=black
BULLETTRAIN_GIT_ROOT_BG=cyan
BULLETTRAIN_GIT_BG=cyan
BULLETTRAIN_DIR_EXTENDED=0
ZSH_THEME_GIT_PROMPT_ADDED=' ✚'
ZSH_THEME_GIT_PROMPT_MODIFIED=' ☀'
ZSH_THEME_GIT_PROMPT_DELETED=' ✖'
ZSH_THEME_GIT_PROMPT_UNTRACKED=' ✲'
ZSH_THEME_GIT_PROMPT_PREFIX=''
ZSH_THEME_GIT_PROMPT_DIRTY=' %F{red}✘%F{black}'
BULLETTRAIN_PROMPT_CHAR=''
