#!/bin/bash

OUTPUT="../site"
SOURCE="`pwd`"

OUTPUT_BRANCH="master"

#What happens if $OUTPUT doesn't exist?!
#cd "$OUTPUT"

if [ ! -d "$OUTPUT" ] || [ ! -d "$OUTPUT/.git" ];
then
    rm -rf "$OUTPUT"
    git clone git@github.com:Defavlt/defavlt.github.com.git "$OUTPUT"
elif [ -d "$OUTPUT/.git" ];
then
    cd "$OUTPUT"
    git pull origin "$OUTPUT_BRANCH"
fi

cd "$OUTPUT"
git co "$OUTPUT_BRANCH"

shopt -s extglob
rm -rf "$OUTPUT"/!(.git|.gitignore|..|.)
 
#Turn it off when you're done, please
shopt -u extglob

cd "$SOURCE"
jekyll build 1>/dev/null
cp -Rf "$SOURCE/.site"/* $OUTPUT

cd "$OUTPUT"
echo "`pwd`"
exit 1
git add *
git commit
git push

cd "$SOURCE"
echo "All done."
