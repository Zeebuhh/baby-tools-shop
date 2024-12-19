# This is the base image of our application image
FROM python:3.12.8

# This is a special directory variable, that can be used to encapsulate 
# all application/container specific files/assets into a separate folder on the system.
WORKDIR /app

# Copy relevant files and assests from the Host during the build process
COPY . $WORKDIR

# Install all dependencies for the application that lives in the container
RUN python -m pip install -r requirements.txt

EXPOSE 5000

# This is the command that will be executed on container launch
ENTRYPOINT ["sh", "-c", "cd babyshop_app && python manage.py migrate && python manage.py runserver 159.69.20.89:5000"]
