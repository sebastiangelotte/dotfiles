# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="/home/kikkirikki/.oh-my-zsh"

# Theme - https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="random"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# Alias for managing dotfiles with git (https://www.atlassian.com/git/tutorials/dotfiles)
# alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias config="lazygit --git-dir=$HOME/.cfg --work-tree=$HOME"
alias timelapse="~/bin/timelapse.sh"
alias pop="~/bin/pop.sh"
alias civ="lazygit --git-dir=$HOME/.local/share/lutris/runners/winesteam/prefix64/drive_c/Program\ Files\ \(x86\)/Steam/steamapps/common/Sid\ Meier\'s\ Civilization\ V/Assets/DLC/.git --work-tree=$HOME/.local/share/lutris/runners/winesteam/prefix64/drive_c/Program\ Files\ \(x86\)/Steam/steamapps/common/Sid\ Meier\'s\ Civilization\ V/Assets/DLC"

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

fzf#vim#with_preview()

export BAT_THEME="Dracula"

# fix weird %-character on new windows https://github.com/vercel/hyper/issues/2144
unsetopt PROMPT_SP

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
