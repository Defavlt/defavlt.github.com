#!/bin/bash

OUTPUT="../site"
SOURCE="`pwd`"

OUTPUT_BRANCH="master"

#What happens if $OUTPUT doesn't exist?!
#cd "$OUTPUT"
shopt -s extglob

if [ ! -d "$OUTPUT" ] || [ ! -d "$OUTPUT/.git" ];
then
    rm -rf "$OUTPUT"
    git clone git@github.com:Defavlt/defavlt.github.com.git "$OUTPUT"
elif [ -d "$OUTPUT/.git" ];
then
    cd "$OUTPUT"
    git co "$OUTPUT_BRANCH"
    git pull origin "$OUTPUT_BRANCH"
fi

cd "$OUTPUT"
git co "$OUTPUT_BRANCH"

rm -rf "$OUTPUT"/!(.git|.gitignore|..|.)
 
#Turn it off when you're done, please

cd "$SOURCE"
jekyll build 1>/dev/null
cp -Rf "$SOURCE/.site"/!("generate.sh") $OUTPUT

cd "$OUTPUT"
git add !(".."|".")/*
git add *
git commit -am "`date`"
git push

cd "$SOURCE"
shopt -u extglob
echo "All done."
