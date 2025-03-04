function fish_prompt
    set -l last_status $status
    
    # Get current user
    set -l user (whoami)
    
    # Get hostname
    set -l host (prompt_hostname -s)
    
    # Current directory 
    set -l dir (prompt_pwd)
    
    # Status indicator if command failed
    set -l stat ""
    if test $last_status -ne 0
        set stat (set_color red)"[$last_status] "(set_color normal)
    end
    
    # Get git info if available
    set -l git_info ""
    if command -q git; and git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l git_branch (git symbolic-ref --short HEAD 2>/dev/null; or git describe --tags --exact-match 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
        set git_info (set_color green)" ("$git_branch")"(set_color normal)
    end
    
    # Format prompt with blue and white colors
    set -l user_part (set_color white)$user(set_color normal)
    set -l host_part (set_color blue)$host(set_color normal)
    set -l dir_part (set_color white)$dir(set_color normal)
    
    # Determine prompt symbol based on root status
    set -l prompt_symbol '$'
    if fish_is_root_user
        set prompt_symbol '#'
    end
    
    # Put it all together in the format [user@hostname:~/path]$ or [root@hostname:~/path]#
    # Also adds git branch if in a git repository
    string join '' -- "["$user_part"@"$host_part":"$dir_part$git_info"]"$prompt_symbol" "
end

# Disable the welcome message
set -U fish_greeting ""

