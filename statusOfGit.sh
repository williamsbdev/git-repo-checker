#!/bin/bash

function check_if_repo_is_clean() {
    MESSAGE_TO_CHECK="$1"
    GIT_STATUS=`git status | grep "${MESSAGE_TO_CHECK}"`
    if [ "$GIT_STATUS" != "" ]; then
        GIT_BRANCH=`git branch | grep "*" | awk -F ' ' '{print $2}'`
        echo "${dir} on branch ${GIT_BRANCH} ${MESSAGE_TO_CHECK}"
    fi
}

#start from the home directory
cd
echo "starting search for git repos..."
for dir in `find ~ -name '.git' | sed 's/\(^.*\).git$/\1/' | grep -v "Library" | grep -v "dotfiles\/vim"`; do
    if [ -d $dir ]; then
        pushd $dir &>/dev/null
        check_if_repo_is_clean "Changes not staged for commit"
        check_if_repo_is_clean "but untracked files present"
        check_if_repo_is_clean "Your branch is ahead of"
    fi
    #return to home directory before working on next git repo
    popd &>/dev/null
done
