set -gxp PATH /usr/local/opt/python@3.9/libexec/bin /usr/local/sbin $HOME/go/bin
set -gx GOPATH $HOME/go
set -gx GOBIN $HOME/go/bin
set -gx EDITOR vim
set -gx GOPRIVATE go.bukalapak.io
set -gx NVM_DIR $HOME/.nvm

if test (arch) = i386
    set HOMEBREW_PREFIX /usr/local

    source /usr/local/opt/asdf/libexec/asdf.fish
else
    set HOMEBREW_PREFIX /opt/homebrew

    # openvpn
    fish_add_path --path /opt/homebrew/opt/openvpn/sbin

    source /opt/homebrew/opt/asdf/libexec/asdf.fish
end

# Add the Homebrew prefix to $PATH. -m flag ensures it's at the beginning
# of the path since the path might already be in $PATH (just not at the start)
fish_add_path -m --path $HOMEBREW_PREFIX/bin

alias intel 'arch -x86_64 /usr/local/bin/fish'

# Point Fish at our local checkout of chruby-fish
set fish_function_path $fish_function_path $HOME/chruby-fish/share/fish/vendor_functions.d

# git prompt settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_dirtystate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_conflictedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_branch cyan --dim --italics

# don't show any greetings
set fish_greeting ""

# don't describe the command for darwin
# https://github.com/fish-shell/fish-shell/issues/6270
function __fish_describe_command
end

# brew install jump, https://github.com/gsamokovarov/jump
status --is-interactive; and source (jump shell fish | psub)

# Senstive functions which are not pushed to Github
# It contains work related stuff, some functions, aliases etc...
source ~/.private.fish

set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths
set -g fish_user_paths /usr/local/opt/mysql-client/bin $fish_user_paths

# auto complete kubectl
kubectl completion fish | source

