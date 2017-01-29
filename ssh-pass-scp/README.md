scp bypass ssh pw

Example 1, copy [1.txt] and [2.txt] in [./a1] to remote
```sh
bash cp.sh ./a1/1.txt ./a1/2.txt Documents/a1
```
Example 2, copy all txt files from [./a1] to remote
```sh
bash cp.sh ./a1/*.txt Documents/a1
```
Example 3, copy all txt and java files from [./a1] to remote:
```sh
bash cp.sh ./a1/*.txt ./a1/*.java Documents/a1
```
Example 4, copy all 1.txt and all java files from [./a1] to remote:
```sh
bash cp.sh ./a1/1.txt ./a1/*.java Documents/a1
```
