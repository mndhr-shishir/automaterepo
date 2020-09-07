# !/bin/bash

# exit if any of the commands in between fail
set -e

# get current branch name
curBranch=$(git symbolic-ref --short -q HEAD)
echo "Current branch: $curBranch"

# ask for confirmation (an escape route)
answer="n"
while [[ "${answer,,}" != "y" ]]; do
    read -p "Continue (y/n)? " answer

    # prompt the user again if the answer is neither 'y' nor 'n'
    if [[ "${answer,,}" != "n" ]]; then
        continue
    fi

    # exit safely if the answer is no
    exit 0
done

# stage all modified files
echo "Staging modified files..."
git add .

# ask user for the commit message
read -p "Enter commit message: " commitmsg

# don't commit if the commit message is empty
if git commit -m "$commitmsg"; then
    # push the current branch to github
    git push -u origin $curBranch
    echo "Git push sucessfull!"
    exit 0
fi

# report the job failed and exit safely
echo "Git push failed!"
exit 1
