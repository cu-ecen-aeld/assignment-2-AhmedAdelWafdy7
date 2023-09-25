#!/bin/bash


if [ $# -ne 2 ]; then
    echo "Usage: $0 <writefile> <writestr>"
    exit 1
fi


writefile="$1"
writestr="$2"


dirname="$(dirname "$writefile")"
mkdir -p "$dirname"

echo "$writestr" > "$writefile"

if [ $? -ne 0 ]; then
    echo "Error: Could not create the file '$writefile'."
    exit 1
fi
echo "File '$writefile' created successfully with the content:"
echo "$writestr"

exit 0

