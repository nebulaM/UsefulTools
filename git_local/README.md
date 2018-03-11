Store remote repo on local disk 

```sh
REPO_ROOT="C:\git_depot"
REMOTE=example_repo

cd $REPO_ROOT
mkdir $REMOTE && cd $REMOTE
# init bare as remote
git init --bare

# go to local repo with code
cd path\\to\\code
git init
git add .
git commit -m "init commit etc."
git remote add origin "$REPO_ROOT\\$REMOTE"
git push origin master

```