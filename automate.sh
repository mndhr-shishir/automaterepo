# exit when any of the commands in between fail
set -e

# get current branch name
curBranch=$(git symbolic-ref --short -q HEAD)
echo "Current branch: $curBranch"

# stage all modified files
git add .
echo "Staging modified files."

# prompt the user to enter the commit message
read -p "Enter commit message: " commitmsg

# don't commit if commit message is empty
if git commit -m "$commitmsg"; then
    # push the current branch to github
    git push -u origin $curBranch
    echo "Git push sucessfull!"
else
    echo "Git push failed!"
fi
