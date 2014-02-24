#!/bin/bash -e
# This script uses pandoc to convert markdown to pdf. 
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "USAGE: ./$0 filename.markdown [output.pdf]"
    exit
fi

filename=$1
if [ $# -eq 2 ]; then
    outputFile=$2
else
    outputFile="${filename%.markdown}.pdf"
fi
texFile=${filename%.markdown}.tex
texFile=${filename%.pandoc}.tex
# now convert the file to pdf
PANDOC="pandoc --data-dir=$HOME/Scripts/pandoc"
INFMT=markdown+tex_math_dollars+latex_macros+subscript+superscript+
echo "Converting $filename to $outputFile using pandoc"
latex="true"
if [[ $latex = "true" ]]; then
    $PANDOC -s -f $INFMT -t latex -o $texFile $filename
    pdflatex -shell-escape $texFile
else
    $PANDOC -s -f $INFMT -o $outputFile $filename
fi

