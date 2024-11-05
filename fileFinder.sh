#!/bin/bash

# Default values for flags
verbose=false
parent_folder="/home"
file_type=".txt"

# Function to display usage
usage() {
    echo "Usage: $0 [-v] [-p parent_folder] [-f file_type]"
    echo "  -v            Enable verbose mode"
    echo "  -p FILE       Specify folder to search in (default: /home)"
    echo "  -f FILE       Specify file type (default: .txt)"
    exit 1
}

# Parse command-line options
while getopts ":vp:f:" opt; do
    case ${opt} in
        v )
            verbose=true
            ;;
        p )
            parent_folder="$OPTARG"
            ;;
        f )
            file_type="$OPTARG"
            ;;
        \? )
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
        : )
            echo "Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done

# Shift away the parsed options
shift $((OPTIND -1))

# Your script logic here
if [ "$verbose" = true ]; then
    echo "Verbose mode is ON"
    echo "Parent folder: $parent_folder"
    echo "File type: $file_type"
fi

# Find all .mp3 files and store them in an array
mapfile -t list < <(find "$parent_folder" -iname "*$file_type" -exec basename {} \;)

# Print the number of found .mp3 files
echo "Number of .mp3 files found: ${#list[@]}"

echo ""


increment=0

# Print a formatted line for each found .mp3 file
for i in "${list[@]}"; do
    if [ $increment -gt 9 ]; then
        if [ $increment -gt 99 ]; then
            if [ $increment -gt 999 ]; then
                if [ $increment -gt 9999 ]; then
                    echo " " $increment "> " $i
                else
                    echo " " $increment " > " $i
                fi
            else
                echo " " $increment "  > " $i
            fi
        else
            echo " " $increment "   > " $i
        fi
    else
        echo " " $increment "    > " $i
    fi
    increment=$(($increment+1))
done

echo ""
