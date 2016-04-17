__Reek configuration and pre-commit hook__

Reek is a popular code smell detector for Ruby, which have simple configuration file .reek.

Git already give as a native configuration .git/hooks/ to do any action after or before git commands.

My solution to make everything automatic  as possible (cause we forgot to do lots of stuff if it is become too complicated):
1. add reek gem to Gemfile <br />
2. .reek -> file with reek configurations <br />
3. /lib/tasks/pre_commit_hook.rake -> this is rake task file for create pre-commit hook file in .git/hooks dir. Enough to run 1st time you clone the project. <br />
4 .git/hooks/pre-commit -> file exist then you run the task mentioned before or you already have it. <br />

__How it works?__

we need to copy .reek file in root_dir
copy pre_commit_hook.rake file to  ./lib/tasks/
run rake pre_commit_hook:init
that is done!
Now every time you run ‘git commit ..’ you will run pre-commit hook script to check code quality.

__Some “-“ about this script:__
it is need to copy files and run rake task (not fully automatic)
if the project already exist and have lots of offences - which files you modify could have the offences from old commits. This means you can fix the offences (yours and existing in the files you changed) or do ignore as mentioned in script.

__Some “+” about the script:__
One time initialise the script with rake task
Guarantee code quality
Easy to add reek config and don’t need to change anything else
