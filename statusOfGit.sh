#!/bin/bash

#start from the home directory
cd
echo "starting search for git repos..."
for dir in `find ~ -name '.git' | sed 's/\(^.*\).git$/\1/'`; do
    if [ -d $dir ]; then
        cd $dir
        branch=`git branch`
        GIT_STATUS=`git status | grep "Changes not staged for commit"`
        if [ "$GIT_STATUS" != "" ]; then
            echo "$dir" 'on branch '
            echo "$branch"
            echo 'changes not staged for commit'
        fi
        GIT_STATUS=`git status | grep "but untracked files present"`
        if [ "$GIT_STATUS" != "" ]; then
            echo "$dir" 'on branch '
            echo "$branch"
            echo 'has untracked files'
        fi
        GIT_STATUS=`git status | grep "Your branch is ahead of"`
        if [ "$GIT_STATUS" != "" ]; then
            echo "$dir" 'on branch '
            echo "$branch"
            echo 'branch is ahead of origin'
        fi
    fi
    #return to home directory before working on next git repo
    cd
done
