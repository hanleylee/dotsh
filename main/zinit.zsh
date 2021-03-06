# Author: Hanley Lee
# Website: https://www.hanleylee.com
# GitHub: https://github.com/hanleylee
# License:  MIT License

export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"
ZINIT_GIT_ROOT="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
### Added by Zinit's installer
if [[ ! -d "$ZINIT_GIT_ROOT" ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$(dirname "$ZINIT_GIT_ROOT")"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_GIT_ROOT" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "${ZINIT_GIT_ROOT}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Common ICE modifiers
@zi_lucid() {
    zinit ice lucid "$@"
}

@zi_w0() {
    @zi_lucid wait'0' "$@"
}

@zi_w1() {
    @zi_lucid wait'1' "$@"
}

@zi_completion() {
    @zi_w1 as'completion' blockf "$@"
}

# 命令补全
@zi_w0 atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# 语法高亮
@zi_w0 atinit='zpcompinit'
zinit light zdharma-continuum/fast-syntax-highlighting

@zi_w0
zinit light zsh-users/zsh-completions

@zi_w0 has'fzf'
zinit light Aloxaf/fzf-tab

@zi_w0
# zinit light urbainvaes/fzf-marks
zinit light "/Users/hanley/github/lang/sh/fzf-marks" # use for debug

@zi_w0
zinit light skywind3000/z.lua

@zi_w0 has'git'
zinit light paulirish/git-open
# ========

zinit snippet OMZL::git.zsh
zinit snippet OMZL::functions.zsh
zinit snippet OMZL::completion.zsh
# zinit snippet OMZL::history.zsh
zinit snippet OMZL::key-bindings.zsh
zinit snippet OMZL::theme-and-appearance.zsh

# ========
zinit snippet OMZP::last-working-dir

@zi_w1
zinit snippet OMZP::sudo

@zi_w1
zinit snippet OMZP::colored-man-pages

@zi_completion has'cargo'
zinit snippet OMZP::cargo

@zi_completion has'docker'
zinit snippet OMZP::docker/_docker

@zi_completion has'fd'
zinit snippet OMZP::fd/_fd

@zi_completion has'pip'
zinit snippet OMZP::pip/_pip

@zi_completion has'pod'
zinit snippet OMZP::pod/_pod

zinit ice has'svn' svn silent wait'1'
zinit snippet OMZP::macos

zinit ice has'svn' svn silent wait'1'
zinit snippet OMZP::flutter

# zinit ice has'svn' has'emacs' svn silent wait'1'
# zinit snippet OMZP::emacs

@zi_w1
zinit snippet OMZP::command-not-found

@zi_w1
zinit snippet OMZP::git-auto-fetch

zinit ice multisrc'*.zsh'
zinit load "$ZDOTDIR/tool"

zinit light HanleyLee/Handy
# zinit light "/Users/hanley/repo/handy" # use for debug

# 为了使用 GitHub 项目的子目录作为 snippet, 需要在 URL中添加 /trunk/{path-to-dir}
# zinit ice svn
# zinit snippet https://github.com/zsh-users/zsh-completions/trunk/src

# @zi_w1
# zinit snippet OMZP::zsh-interactive-cd

# zinit ice svn
# zinit snippet OMZP::gitfast
#}}}

