# Author: Hanley Lee
# Website: https://www.hanleylee.com
# GitHub: https://github.com/hanleylee
# License:  MIT License

_path_arr=(
    "$ZDOTDIR/main/option.zsh"
    "$ZDOTDIR/main/completion.zsh"
    "$ZDOTDIR/main/zinit.zsh"
    "$ZDOTDIR/main/eval_tools.zsh"
)

# MARK: Tools
_path_arr+=(
    "$HOME/.cargo/env"
    "$XDG_CONFIG_HOME/broot/launcher/bash/br"
    "$HOMEBREW_PREFIX/etc/profile.d/autojump.sh"
)
if [[ $TERM_PROGRAM == "iTerm.app" ]] && [[ -d "$ZDOTDIR/.iterm2_shell_integration.zsh" ]]; then
    _path_arr+=("$ZDOTDIR/.iterm2_shell_integration.zsh")
fi

source_if_exists "${_path_arr[@]}"

unset _path_arr
