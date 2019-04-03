echo current directory:%cd%
git status 
git add .
set /p declation=commit message:
git commit -m "%declation%"
git push origin master
pause