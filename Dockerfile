# Use the official PostgreSQL 15 image as the base image
FROM postgres:15

# Install necessary tools
RUN apt-get update && apt-get install -y \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
WORKDIR /usr/src/app

# Copy the shell script and SQL files into the container
COPY apply_sql_files.sh ./
COPY sql_files/ ./sql_files/

# Make the shell script executable
RUN chmod +x apply_sql_files.sh

# Set environment variables (example values)
# These should be overridden by the user when running the container
ENV DB_HOST=db_host
ENV DB_PORT=5432
ENV DB_NAME=db_name
ENV DB_USER=db_user
ENV DB_PASSWORD=db_password

# Command to run the shell script
CMD ["./apply_sql_files.sh"]
