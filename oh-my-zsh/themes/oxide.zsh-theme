# Oxide theme for Zsh
#
# Author: Diki Ananta <diki1aap@gmail.com>
# Repository: https://github.com/dikiaap/dotfiles
# License: MIT

# Modified by: Iago Lourenço @iaglourenco


# Prompt:
# %F => Color codes
# %f => Reset color
# %~ => Current path
# %(x.true.false) => Specifies a ternary expression
#   ! => True if the shell is running with root privileges
#   ? => True if the exit status of the last command was success
#
# Git:
# %a => Current action (rebase/merge)
# %b => Current branch
# %c => Staged changes
# %u => Unstaged changes
#
# Terminal:
# \n => Newline/Line Feed (LF)

setopt PROMPT_SUBST

autoload -U add-zsh-hook
autoload -Uz vcs_info

# Use True color (24-bit) if available.
if [[ "${terminfo[colors]}" -ge 256 ]]; then
    oxide_turquoise="%F{73}"
    oxide_orange="%F{179}"
    oxide_red="%F{167}"
    oxide_limegreen="%F{107}"
else
    oxide_turquoise="%F{cyan}"
    oxide_orange="%F{yellow}"
    oxide_red="%F{red}"
    oxide_limegreen="%F{green}"
fi

# Reset color.
oxide_reset_color="%f"

# VCS style formats.
FMT_UNSTAGED="%{$oxide_reset_color%} %{$oxide_orange%}●"
FMT_STAGED="%{$oxide_reset_color%} %{$oxide_limegreen%}✚"
FMT_ACTION="(%{$oxide_limegreen%}%a%{$oxide_reset_color%})"
FMT_VCS_STATUS="on %{$oxide_turquoise%} %b%u%c%{$oxide_reset_color%}"

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr    "${FMT_UNSTAGED}"
zstyle ':vcs_info:*' stagedstr      "${FMT_STAGED}"
zstyle ':vcs_info:*' actionformats  "${FMT_VCS_STATUS} ${FMT_ACTION}"
zstyle ':vcs_info:*' formats        "${FMT_VCS_STATUS}"
zstyle ':vcs_info:*' nvcsformats    ""
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

# Check for untracked files.
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
            git status --porcelain | grep --max-count=1 '^??' &> /dev/null; then
        hook_com[staged]+="%{$oxide_reset_color%} %{$oxide_red%}●"
    fi
}

# Executed before each prompt.
add-zsh-hook precmd vcs_info

# Oxide prompt style with some modifications.
PROMPT=$'\n%{$oxide_limegreen%} %B$USER in%b% %F{cyan}% %~%{$oxide_reset_color%} ${vcs_info_msg_0_} \n %(?.%{%F{white}%}.%{$oxide_red%})%(!.#.❯)%{$oxide_reset_color%} '




# Time spent prompt


command_time_preexec() {
  timer=${timer:-$SECONDS}
}

command_time_precmd() { 
  if [ $timer ]; then
    elapsed=$(($SECONDS - $timer))

    if [ -n "$TTY" ]; then
        
        # print $elapsed
        
        if [ $elapsed -gt 0 ]; then
        
                hours=$((${elapsed}/3600))
                min=$((${elapsed}/60))
                sec=${elapsed}
        
                if [ "${elapsed}" -le 60 ]; then
       
                        time_spent="${elapsed} s"

                elif [ "${elapsed}" -gt 60 ] && [ "${elapsed}" -le 180 ]; then
                        time_spent="${min} min ${sec} s"
            
                else
                
                        if [ "${hours}" -gt 0 ]; then
                            min=$(($min%60))
                            time_spent="${hours} h ${min} min ${sec} s"
                        else
                            time_spent="${min} min ${sec} s"
                        fi
                fi
        
        
        PROMPT=$'\n%{$oxide_limegreen%} %B$USER in%b% %F{cyan}% %~%{$oxide_reset_color%} ${vcs_info_msg_0_} %B%F{yellow}% took %b% ${time_spent}%{$oxide_reset_color%} \n %(?.%{%F{white}%}.%{$oxide_red%})%(!.#.❯)%{$oxide_reset_color%} '
        else
        PROMPT=$'\n%{$oxide_limegreen%} %B$USER in%b% %F{cyan}% %~%{$oxide_reset_color%} ${vcs_info_msg_0_} \n %(?.%{%F{white}%}.%{$oxide_red%})%(!.#.❯)%{$oxide_reset_color%} '

        fi
    fi
    unset timer
  fi
}

precmd_functions+=(command_time_precmd)
preexec_functions+=(command_time_preexec)