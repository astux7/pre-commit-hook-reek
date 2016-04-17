__Reek configuration and pre-commit hook__

[Reek](https://github.com/troessner/reek) is a popular code smell detector for Ruby, which have simple configuration file ```.reek```.

[Git](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks) already give as a native configuration .git/hooks/ to do any action after or before git commands like ```pre-commit```.

My solution to make everything automatic as possible (cause we forget to do lots of stuff if it is become too complicated): <br />
1. add *reek* gem to *Gemfile* (and do simple bundle install) <br />
2. add ```.reek``` file with reek configurations from example or your own <br />
3. add ```/lib/tasks/pre_commit_hook.rake``` and copy code. This is rake task file to create pre-commit hook file in .git/hooks dir. Enough to run 1st time you clone the project you want to configure. <br />
4 ```.git/hooks/pre-commit``` file should exist then you run the task mentioned before or you already have it. <br />

__How it works?__ <br />
When you copy all the files just run rake task: <br />
```pre_commit_hook:init``` - for the first time and follow the instruction if you see any errors.
__Easy?!__ <br />
Now every time you run ```git commit -m "message"``` you will run pre-commit hook script to check code quality.

__Some “-“ about this script:__
[-]Need to copy files and run rake task (not fully automatic) <br />
[-]if the project already exist and have lots of offences - which files you modify could have the offences from old commits. This means you can fix the offences (yours and existing in the files you changed) or do ignore as mentioned in script.

__Some “+” about the script:__
[+]One time initialise the script with rake task <br />
[+]Guarantee code quality <br />
[+]Easy to modify reek config and don’t need to change anything else for pre-commit hook  <br />


__Author: Asta B. (C) 2016__

Lisense: Open Source
