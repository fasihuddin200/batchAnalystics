#!/bin/bash

# Check if date parameter is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <YYYY-MM-DD>"
    exit 1
fi

# Extract year, month, and day from input date
INPUT_DATE=$1
year=$(date -d "$INPUT_DATE" +%Y)
month=$(date -d "$INPUT_DATE" +%m)
day=$(date -d "$INPUT_DATE" +%d)

# Define local source paths
LOCAL_LOGS_DIR="/mnt/data/raw_data/user_logs.csv"
LOCAL_METADATA_DIR="/mnt/data/raw_data/content_metadata.csv"

# Define HDFS target directories
HDFS_LOGS_DIR="/raw/logs/$year/$month/$day/"
HDFS_METADATA_DIR="/raw/metadata/$year/$month/$day/"

# Create HDFS directories if they don't exist
hdfs dfs -mkdir -p $HDFS_LOGS_DIR
hdfs dfs -mkdir -p $HDFS_METADATA_DIR

# Copy data to HDFS
hdfs dfs -put -f "$LOCAL_LOGS_DIR" "$HDFS_LOGS_DIR"
hdfs dfs -put -f "$LOCAL_METADATA_DIR" "$HDFS_METADATA_DIR"

echo "Data ingestion completed for $INPUT_DATE."
