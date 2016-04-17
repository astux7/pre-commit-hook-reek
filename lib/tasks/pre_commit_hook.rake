namespace :pre_commit_hook do

  task :init do
    check_and_create();
  end

  task :override do
    # overrides the previous file if existed
    create();
  end

  task :clean do
    # deletes  the pre-commit hook file
    clean();
  end

  def git_precommit_hook_path
    './.git/hooks/pre-commit'
  end

  def messages
    {
      exist:   '"pre-commit" file already exist, if you want to override do "pre_commit_hook:override"',
      created: 'succesfully created "pre-commit" file',
      deleted: '"pre-commit" file deleted',
      missing: 'Nothing to delete'
    }
  end

  def output(id)
    puts messages[id]
  end

  def create
    # overrides the current file or creates new if not existed
    File.open(git_precommit_hook_path, 'w:binary') { |file| file.write(pre_commit_hook_text) }
    output(:created)
  end

  def check_and_create
    # check if file exist and notify
    return output(:exist) if File.exist?(git_precommit_hook_path)
    create
  end

  def clean
    if File.exist?(git_precommit_hook_path)
      File.delete(git_precommit_hook_path)
      output(:deleted)
    else
      output(:missing)
    end
  end

  def pre_commit_hook_text
%q(#!/bin/bash
## START PRECOMMIT HOOK

echo -e "\x1B[01;94m Precommit script running... \x1B[0m"

files_modified=`git status --porcelain | awk '{ if ($1 != "D" && $3 == "->") print $4; else if ($1 != "D") print $2; }'`
failed=false

if [ ${#files_modified[@]} -gt 0 ]; then
    for file in $files_modified; do
        echo -e "\x1B[01;94m Checking code smell for ${file}... \x1B[0m"
        if [[ $file == *.rb ]]; then
            reek $file
            if [ $? != 0 ]; then
                echo -e "\x1B[31m [!] File ${file} failed \x1B[0m"
                failed=true
            else
                echo -e "\x1B[01;92m no offences found... \x1B[0m"
            fi
            if grep --color -n "binding.pry" $file; then
                echo "File ${f} failed - found 'binding.pry'"
                exit 1
            fi
        fi
        if [ $? != 0 ]; then
            echo -e "\x1B[31m [!]File ${file} failed \x1B[0m"
            exit 1
        fi
    done
else
    echo -e "\x1B[01;92m Nothing to commit... \x1B[0m"
fi

if $failed; then
    echo -e "\x1B[31m [!] Commit rejected, see the errors above... if you want to continue anyway use flag '--no-verify' \x1B[0m"
    exit 1
fi

exit)
  end

end

