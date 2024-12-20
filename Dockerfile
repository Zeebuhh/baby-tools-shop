# Use an official Python runtime as a base image
FROM python:3.9

# Set the working directory in the container to /app
WORKDIR /app

# Copy the project files from the host machine to the container
COPY babyshop_app /app
COPY requirements.txt /app

# Install project dependencies specified in requirements.txt
RUN pip install -r requirements.txt

# Expose port 8025 to allow external connections to the application
EXPOSE 8025

# Define the command to run the application
ENTRYPOINT ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:8025"]