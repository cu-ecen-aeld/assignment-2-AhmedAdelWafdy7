#!/bin/bash

# Check if both arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <filesdir> <searchstr>"
    exit 1
fi


filesdir="$1"
searchstr="$2"


if [ ! -d "$filesdir" ]; then
    echo "Error: $filesdir is not a directory."
    exit 1
fi


count_matching_lines() {
    local file="$1"
    local count=0

    while IFS= read -r line; do
        if [[ "$line" == *"$searchstr"* ]]; then
            ((count++))
        fi
    done < "$file"

    echo "$count"
}


process_directory() {
    local dir="$1"
    local file_count=0
    local line_count=0

    while IFS= read -r -d '' file; do
        if [ -f "$file" ]; then
            ((file_count++))
            lines_matching=$(count_matching_lines "$file")
            ((line_count += lines_matching))
        fi
    done < <(find "$dir" -type f -print0)

    echo "The number of files are $file_count and the number of matching lines are $line_count"
}


process_directory "$filesdir"

exit 0

