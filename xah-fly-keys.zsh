bindkey -N xah-fly-keys-command
bindkey -N xah-fly-keys-insert viins
bindkey -A xah-fly-keys-insert main

#insert mode


bindkey -M xah-fly-keys-insert "^[[19~" _xah-fly-command-mode

bindkey -M xah-fly-keys-insert "^H" undefined-key
bindkey -M xah-fly-keys-insert "^Q" undefined-key
bindkey -M xah-fly-keys-insert "^U" undefined-key 
bindkey -M xah-fly-keys-insert "^V" undefined-key 
bindkey -M xah-fly-keys-insert "^W" undefined-key
bindkey -M xah-fly-keys-insert "^[" undefined-key


#command mode
bindkey -M xah-fly-keys-command "^J" .accept-line
bindkey -M xah-fly-keys-command "^M" .accept-line
bindkey -M xah-fly-keys-command "u" _xah-fly-insert-mode
bindkey -M xah-fly-keys-command "n" forward-char
bindkey -M xah-fly-keys-command "h" backward-char
bindkey -M xah-fly-keys-command "g" backward-word
bindkey -M xah-fly-keys-command "r" forward-word
bindkey -M xah-fly-keys-command "d" beginning-of-line
bindkey -M xah-fly-keys-command "s" end-of-line
bindkey -M xah-fly-keys-command "e" backward-delete-char
bindkey -M xah-fly-keys-command "." backward-delete-word
bindkey -M xah-fly-keys-command "p" kill-word
bindkey -M xah-fly-keys-command "(" delete-char-or-list
bindkey -M xah-fly-keys-command "c" up-line-or-history
bindkey -M xah-fly-keys-command "t" down-line-or-history 
bindkey -M xah-fly-keys-command "j" x-copy-region-as-kill  
bindkey -M xah-fly-keys-command "y" set-mark-command  
bindkey -M xah-fly-keys-command "q" x-kill-region  
bindkey -M xah-fly-keys-command "k" x-yank
bindkey -M xah-fly-keys-command "b" _xah-isearch
bindkey -M xah-fly-keys-command "z" vi-match-bracket

function _xah-fly-command-mode {
    bindkey -A xah-fly-keys-command main
    echo -ne '\e[1 q'
}
function _xah-fly-insert-mode {
    bindkey -A xah-fly-keys-insert main
    echo -ne '\e[5 q'
}
function x-copy-region-as-kill () {
    zle copy-region-as-kill
    ((REGION_ACTIVE=0))
    print -rn $CUTBUFFER | xsel -i -b

}
function x-kill-region () {
    zle kill-region
    ((REGION_ACTIVE=0))
    print -rn $CUTBUFFER | xsel -i -b
}
function x-yank () {
    CUTBUFFER=$(xsel -o -b </dev/null)
    zle yank
}

function _xah-isearch(){
    _xah-fly-insert-mode
    zle history-incremental-search-backward
}
zle -N _xah-fly-command-mode
zle -N _xah-fly-insert-mode
zle -N x-copy-region-as-kill
zle -N x-kill-region
zle -N x-yank
zle -N _xah-isearch
echo -ne '\e[5 q'
