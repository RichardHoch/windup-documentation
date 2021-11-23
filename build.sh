#!/bin/bash

FILES=`find docs -name 'master.adoc'`
BASE_URL=https://windup.github.io/windup-documentation

for f in $FILES; do
  asciidoctor --failure-level WARN -b xhtml5 -d book $f
done

echo "HTML files built"

rm index.adoc > /dev/null 2>&1

cat << EOF > index.adoc
= Windup documentation

EOF

for f in $FILES; do
  echo -e "* link:$BASE_URL/$(dirname $f)/master.html[$(dirname $f | sed 's/docs\///g; s/_/ /g; s/-/ /g' )]" >> index.adoc
done

echo "index.adoc built"
