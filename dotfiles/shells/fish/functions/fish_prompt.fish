function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
  set -l last_status $status

  set -l cyan (set_color 88c0d0)
  set -l yellow (set_color ebcb8b)
  set -l red (set_color red)
  set -l blue (set_color blue)
  set -l green (set_color 8cbe8e)
  set -l normal (set_color normal)

  # set -l cwd $cyan(basename (pwd | sed "s:^$HOME:~:"))
  set -l cwd $cyan(prompt_pwd)
  echo
  # Display [venvname] if in a virtualenv
  if set -q VIRTUAL_ENV
      echo -n -s (set_color -b cyan black) '[' (basename "$VIRTUAL_ENV") ']' $normal ' '
  end

  # Print pwd or full path
  echo -n -s $cwd $normal

  # Show git branch and status
  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)

    if [ (_git_is_dirty) ]
      set git_info $yellow $git_branch "±" $normal
    else
      set git_info $green $git_branch $normal
    end
    echo -n -s ' · ' $git_info $normal
  end

  set -l prompt_color $red
  if test $last_status = 0
    set prompt_color $normal
  end

  # Terminate with a nice prompt char
  echo -e -n -s $prompt_color ' ⟩ ' $normal
end
