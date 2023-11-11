#!/bin/bash

function print_help {
    echo "Usage: $0 <input_directory>"
    echo "This script converts all MKV files in the specified directory to MP4 using H.265/HEVC codec for video."
}

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
    print_help
    exit 1
fi

# Assign argument to a variable for better readability
input_directory="$1"

# Check if the input directory exists
if [ ! -d "$input_directory" ]; then
    echo "Error: Input directory '$input_directory' does not exist."
    exit 1
fi

# Change to the specified directory
cd "$input_directory"

# Loop through all .mkv files in the directory
for input_file in *.mkv; do
    # Skip if no .mkv files are found
    if [ "$input_file" == "*.mkv" ]; then
        echo "No MKV files found in the directory."
        break
    fi

    # Set the output file name
    output_file="${input_file%.mkv}.mp4"

    # Perform the conversion
    echo "Converting '$input_file' to '$output_file' using H.265/HEVC codec..."
    ffmpeg -i "$input_file" -c:v libx265 -crf 20 -c:a copy "$output_file"
done

echo "All conversions completed."

