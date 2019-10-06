# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

fpath=(/usr/local/share/zsh-completions/src ${fpath})

# Customize to your needs...
autoload -Uz compinit && compinit

bindkey -e

# 色を使用出来るようにする
autoload -Uz colors
colors

setopt auto_list

setopt auto_menu

zstyle ':completion:*:default' menu select=1

export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

setopt auto_cd

export LANG=ja_JP.UTF-8
HISTFILE=$HOME/.zsh-history
HISTSIZE=1000000
SAVEHIST=1000000

setopt share_history

# zplugが無ければgitからclone
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

# zplugを使う
source ~/.zplug/init.zsh

# 自分自身をプラグインとして管理
zplug "zplug/zplug", hook-build:'zplug --self-manage'

# インストールしてないプラグインはインストール
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load –verbose

# 補完を更に強化する
# pacman や yaourt のパッケージリストも補完するようになる
zplug "zsh-users/zsh-completions"

# git の補完を効かせる
# 補完＆エイリアスが追加される
zplug "plugins/git",   from:oh-my-zsh
zplug "peterhurford/git-aliases.zsh"

# 入力途中に候補をうっすら表示
zplug "zsh-users/zsh-autosuggestions"

# コマンドを種類ごとに色付け
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# ヒストリの補完を強化する
zplug "zsh-users/zsh-history-substring-search", defer:3

# 本体（連携前提のパーツ）
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux

# fzf でよく使う関数の詰め合わせ
zplug "mollifier/anyframe"

# ディレクトリ移動を高速化（fzf であいまい検索）
zplug "b4b4r07/enhancd", use:init.sh

# git のローカルリポジトリを一括管理（fzf でリポジトリへジャンプ）
zplug "motemen/ghq", as:command, from:gh-r
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export CUDA_HOME="/usr/local/cuda-10.1"
export PATH="$CUDA_HOME/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/lib:$CUDA_HOME/lib64:$LD_LIBRARY_PATH"
export CPATH="/usr/local/include:$CUDA_HOME/include:$CPATH"
export INCLUDE_PATH="$CUDA_HOME/include"

export PIPENV_VENV_IN_PROJECT=true

