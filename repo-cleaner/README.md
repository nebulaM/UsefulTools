#Clean Repo

See [bfg-repo-cleaner](https://github.com/rtyley/bfg-repo-cleaner)

##Example Usage

Scan all **java** files in repo **ABC.git** and replace unwanted words defined by replacements.txt  

```sh
git clone --mirror https://github.com/nebulaM/ABC
java -jar bfg-1.12.14.jar  --replace-text replacements.txt -fi *.java ABC.git
cd ABC.git
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git push
```