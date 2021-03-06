# Author: Hanley Lee
# Website: https://www.hanleylee.com
# GitHub: https://github.com/hanleylee
# License:  MIT License

# check first, or the script will end wherever it fails
# zmodload zsh/regex 2>/dev/null && _has_re=1 || _has_re=0

# MARK: 仅用于添加一些需要在初始化开始时就需要的公共变量或方法

# System name
system_name=$(uname)
arch_name=$(uname -m)

if [[ $system_name == "Darwin" ]]; then
    if [[ "${arch_name}" = "x86_64" ]]; then
        export HOMEBREW_PREFIX='/usr/local'
        if [ "$(sysctl -in sysctl.proc_translated)" = "1" ]; then
            ARCH_MSG="Running on Darwin(Rosetta 2)"
        else
            ARCH_MSG="Running on Darwin(native Intel)"
        fi
    elif [[ "${arch_name}" = "arm64" ]]; then
        export HOMEBREW_PREFIX="/opt/homebrew"
        ARCH_MSG="Running on Darwin(ARM)"
        # elif [[ $arch_name =~ "iPhone" ]]; then
        #     export HOMEBREW_PREFIX='/usr/local'
        #     echo "Running on iPhone"
        # elif [[ $arch_name =~ "iPad" ]]; then
        #     export HOMEBREW_PREFIX='/usr/local'
        #     echo "Running on iPad"
    else
        ARCH_MSG="Running on ${system_name}(${arch_name})"
    fi
else
    ARCH_MSG="Running on ${system_name}(${arch_name})"
fi
export ARCH_MSG

# all command passed exist or not
# -> Bool
function command_exists() {
    for cmd in "$@"; do
        # command -v "$cmd" &>/dev/null || return 1             # path 中的工具, alias 与 function 都会返回 true
        (( $+commands[$cmd] )) # 只会在 path 中找到真正可用的命令, alias 与 function 都不算
    done
    # command -v $1 &> /dev/null
    # [[ -x "$(command -v $1)" ]]
}

function is_home() {
    [[ ${(L)HOST} =~ "home" ]]
}

function is_work() {
    [[ ${(L)HOST} =~ "work" ]]
}

function is_hanley() {
    [[ ${(L)HOST} =~ "hanley" ]]
}

function is_tmux() {
    [[ -n "$TMUX" ]]
}
# source if file exists, can pass many file
# -> Void
function source_if_exists() {
    for file in "$@"; do
        [[ -f "$file" ]] && source "$file"
    done
}

# Extend $PATH without duplicates
function insert_path_if_exists() {
    [[ -d "$1" ]] || return # detect if it is a directory, return if not
    # if ! $( echo "$PATH" | tr ":" "\n" | grep -qx "$1" ) ; then
    export PATH="$1:$PATH"
    # fi
}

# insert path to variable, the first arg is variable name, the remain variable is path list
# -> Void
function insert_path_to_variable() {
    env_var_name="$1" # just the variable name, such as 'PATH'
    # env_var_content="${!env_var_name}" # real content under the variable name, such as '/Users/hanley/.pyenv/shims'
    eval "env_var_content=\"\${$env_var_name}\"" # zsh doesn't support indirect expansion, so we have to use eval!
    for local_path in "${@:2}"; do
        [ -d "$local_path" ] || continue   # exit if path isn't exist
        if [ -z "$env_var_content" ]; then # don't add ':' if this variable is empty
            env_var_content="$local_path"
        else
            env_var_content="${local_path}:${env_var_content}"
        fi
        eval "${env_var_name}=$env_var_content" # use eval to set value for variable, such as 'PATH=/Users/hanley/...'
    done
    export "${env_var_name?}" # export, such as 'export PATH'
}

function mkdir_if_not_exists() {
    for dir in "$@"; do
        [[ -d "$dir" ]] || mkdir -pv "$dir"
    done
}
