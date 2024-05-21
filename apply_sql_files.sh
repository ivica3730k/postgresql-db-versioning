#!/bin/bash

# Check if the required environment variables are set
if [ -z "$DB_HOST" ]; then
  echo "Error: DB_HOST environment variable is not set."
  exit 1
fi

if [ -z "$DB_PORT" ]; then
  echo "Error: DB_PORT environment variable is not set."
  exit 1
fi

if [ -z "$DB_NAME" ]; then
  echo "Error: DB_NAME environment variable is not set."
  exit 1
fi

if [ -z "$DB_USER" ]; then
  echo "Error: DB_USER environment variable is not set."
  exit 1
fi

if [ -z "$DB_PASSWORD" ]; then
  echo "Error: DB_PASSWORD environment variable is not set."
  exit 1
fi

# Sleep for 10 seconds to wait for the database to start
sleep 10

# Export PGPASSWORD to avoid password prompt
export PGPASSWORD="$DB_PASSWORD"

# Directory containing the SQL files
SQL_DIR="./sql_files"

# Find and sort the SQL files, giving precedence to files without 'a' in the name
SQL_FILES=$(find "$SQL_DIR" -type f -name '*.sql' | grep -v 'a' | sort)
SQL_FILES_A=$(find "$SQL_DIR" -type f -name '*.sql' | grep 'a' | sort)

# Print files to apply in order
echo "The following SQL files will be applied in order:"
for FILE in $SQL_FILES $SQL_FILES_A; do
  if [[ $FILE == *.sql ]]; then
    echo "$FILE"
  fi
done

# Wait for 5 seconds before applying the files
echo "Waiting for 5 seconds before applying the SQL files..."
sleep 5

# Apply each SQL file using psql
for FILE in $SQL_FILES $SQL_FILES_A; do
  if [[ $FILE == *.sql ]]; then
    echo "Applying $FILE..."
    psql -v ON_ERROR_STOP=1 -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -U "$DB_USER" -f "$FILE"
    if [ $? -ne 0 ]; then
      echo "Error: Failed to apply $FILE"
      exit 1
    else
      echo "File $FILE applied successfully."
    fi
  fi
done

echo "All SQL files applied successfully."
