# This is the base image of our application image
FROM python:3.9

# This is a special directory variable, that can be used to encapsulate 
# all application/container specific files/assets into a separate folder on the system.
WORKDIR /app

# Copy relevant files and assets from the Host during the build process
COPY . $WORKDIR

# Copy the .env file into the container
COPY .env $WORKDIR/.env

# Install all dependencies for the application that lives in the container
RUN python -m pip install -r requirements.txt

# Expose the port the app will run on
EXPOSE 8025

# This is the command that will be executed on container launch
ENTRYPOINT ["sh", "-c", "cd babyshop_app && python manage.py migrate && python manage.py runserver 0.0.0.0:8025"]
