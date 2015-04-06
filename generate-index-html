#!/bin/bash

# Generates a basic index.html file, listing the contents of the directory.
#
# - nwinant


# Configuration

archive_old_indexes=false
omit_indexes=false
title="Index of ${PWD##*/}"
#css_link='/blah/blah/blah.css'
header=$title:
footer="Index generated on $(date)"

index=index.html
index_old=${index}_$(date '+%Y-%m-%d_%H-%M-%S')
index_tmp=${index}_tmp


# Clean up build space

if [ -e "$index" ]; then
	if [ "$archive_old_indexes" = true ]; then
		mv $index $index_old
		echo Moved old $index to $index_old
	else
		rm $index
		echo Deleted old $index
	fi
fi


# Generate header

if [ -n "$css_link" ] ; then
	css_href="<link href='$css_link' rel='stylesheet' type='text/css'>"
else
	css_href=
fi
read -r -d '' header_html << EOM
<html>
  <head>
    <title>$title</title>
    $css_href
  </head>
  <body>
    <div class="fileIndex">
      <p class="header">$header</p>
      <ul>
EOM
echo "$header_html" > $index


# Generate body

rm -f $index_tmp
ls -1 > $index_tmp
if [ "$omit_indexes" = true ]; then
	echo Omitting indexes...
	sed -i 's:^'${index}'.*::g' $index_tmp
fi
sed -i 's:^'${index_tmp}'$::g' $index_tmp
sed -i '/^\s*$/d' $index_tmp
sed -i 's:\(.*\):        <li><a href="\1">\1</a></li>:g' $index_tmp
cat $index_tmp >> $index
rm -f $index_tmp


# Generate footer

read -r -d '' footer_html << EOM
</ul>
      <p class="footer">$footer</p>
    </div>
  </body>
</html>
EOM
echo "      $footer_html" >> $index


echo Generated $index

