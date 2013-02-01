#!/bin/bash
# Cross-referencing web pages
#
# Heikki, 19-Jun-2010

echo "scanning..."
grep -Ri 'a href' * | 
    grep -v '~:' | grep -v CVS |
    perl -pe 's/^([^:]+):.*a href="?([^"#>]+).*$/$1 $2  /i ' > /tmp/xref.1

echo "Cross reference list of `pwd` " > xref.txt
date >> xref.txt


for F in `cat /tmp/xref.1 | 
          perl -pe s/:.*$// | 
          cut -d' ' -f1 | 
          sort -u | 
          grep -v \~`
do
          ## grep '.php' | 
    #echo 
    #echo
    #echo "Page $F contains these links:"
    #egrep "^$F" /tmp/xref.1 | cut -d ' ' -f2
    echo  >> xref.txt
    echo "pages that link to $F" >> xref.txt
    grep $F /tmp/xref.1 | 
       cut -d' ' -f1 | 
       grep -v `basename $F` |
       sort -u  >> xref.txt
done

echo "List created in xref.txt"


