#!/bin/bash
#start from the home directory
cd
for dir in `find -name '.git' | sed 's/\(^.*\).git$/\1/'`; do
    if [ -d $dir ]; then
        cd $dir
        GIT_STATUS=`git status | grep "Changes not staged for commit\|but untracked files present\|Your branch is ahead of"`
        if [ "$GIT_STATUS" != "" ]; then
            branch=`git branch`
            echo "$dir" 'on branch '
            echo "$branch"
            echo 'has changes to be committed'
        fi
        #return to home directory before working on next git repo
    fi
    cd
done
