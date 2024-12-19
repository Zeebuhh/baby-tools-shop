# E-Commerce Project for Baby Tools

## Table of Contents

- [Description](#description)
- [Quickstart](#quickstart)
- [Usage](#usage)
  - [Configuration Details](#configuration-details)
  - [Running the Application](#running-the-application)
  - [Docker Integration](#docker-integration)
  - [Deployment on Virtual Machine](#deployment-on-virtual-machine)
- [Technologies Used](#technologies-used)
- [Hints](#hints)
- [Screenshots](#screenshots)
- [Conclusion](#conclusion)

## Description

This repository hosts an e-commerce project tailored for baby products. It is designed to provide a seamless online shopping experience with functionalities like product display, filtering options, user authentication, and detailed product views. The repository also demonstrates advanced concepts such as containerization using Docker and deployment setups for production readiness. This project is particularly useful for developers looking to learn or implement scalable Django-based web applications.

## Quickstart

### Prerequisites

- Python 3.9+
- pip
- Virtual Environment (venv)
- Docker (optional for containerization)
- Git

### Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-repo-name
   ```
2. **Set up the virtual environment:**
   ```bash
   cd {project_directory}
   python -m venv env
   source env/bin/activate  # On Windows: `env\Scripts\activate`
   ```
3. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```
4. **Set up environment variables:**
   Create a `.env` file with the following values:
   ```env
   SECRET_KEY={your_secret_key}
   DEBUG=True
   ALLOWED_HOSTS=localhost,127.0.0.1
   ```
5. **Run database migrations:**
   ```bash
   python manage.py migrate
   ```
6. **Start the development server:**
   ```bash
   python manage.py runserver
   ```
7. **Access the application:** Open your browser and navigate to `http://127.0.0.1:8000/`.

## Usage

### Configuration Details

- **Django Settings:** Located in `babyshop_app/babyshop/settings.py`. This file allows you to modify core configurations, such as database settings, static files, and application-specific settings.
- **Routing:** URL configurations are managed in `urls.py` files across subdirectories. Customize these files to add or modify routes as needed.
- **Environment Variables:** Use a `.env` file to securely configure sensitive data. Ensure the `.env` file is excluded from version control by adding it to `.gitignore`.

### Running the Application

1. **Activate virtual environment:**
   ```bash
   source env/bin/activate  # On Windows: `env\Scripts\activate`
   ```
2. **Run migrations and start the server:**
   ```bash
   python manage.py migrate
   python manage.py runserver
   ```
3. **Access the application at:** `http://127.0.0.1:8000/`.

### Docker Integration

1. **Create a Dockerfile:** Place this in the project root:

   ```dockerfile
   # Use an official Python runtime as a base image
   FROM python:3.9

   # Set the working directory in the container to /app
   WORKDIR /app

   # Copy the project files from the host machine to the container
   COPY . /app

   # Install project dependencies specified in requirements.txt
   RUN pip install -r requirements.txt

   # Expose port 8025 to allow external connections to the application
   EXPOSE 8025

   # Define the command to run the application
   ENTRYPOINT ["sh", "-c", "cd {project_directory} && python manage.py migrate && python manage.py runserver 0.0.0.0:8025"]
   ```

   **Explanation of each line:**

   - `FROM python:3.9`: Specifies the base image. This is an official Python image with version 3.9 installed.
   - `WORKDIR /app`: Sets the working directory inside the container to `/app`. All subsequent commands will run in this directory.
   - `COPY . /app`: Copies all the files from the project directory on the host machine to the `/app` directory in the container.
   - `RUN pip install -r requirements.txt`: Installs all Python dependencies listed in `requirements.txt`.
   - `EXPOSE 8025`: Indicates that the application will run on port 8025 and makes this port accessible to the host system.
   - `ENTRYPOINT`: Defines the command to start the application. It ensures database migrations are applied and then starts the Django development server, binding it to all network interfaces (`0.0.0.0`).

2. **Additional Configurations:**

   - **Customizing Ports:** Modify `EXPOSE` and the `runserver` port in `ENTRYPOINT` to use a different port if needed.
   - **Environment Variables:** Use a `COPY` command to include the `.env` file or configure them in your deployment environment.
   - **Static Files:** Add commands to collect static files if deploying to a production environment:
     ```dockerfile
     RUN python manage.py collectstatic --noinput
     ```
   - **Database Configuration:** Update the `DATABASES` setting in `settings.py` to use a production database like PostgreSQL or MySQL.

3. **Build the Docker image:**
   ```bash
   docker build -t {project_name} -f Dockerfile .
   ```
4. **Run the container:**
   ```bash
   docker run -it --rm -p 8025:8025 {project_name}
   ```

### Deployment on Virtual Machine

1. **Clone the repository on VM:**
   ```bash
   git clone https://github.com/your-repo-name
   ```
2. **Copy `.env` file to the VM:**
   Ensure it contains the necessary variables.
3. **Build Docker image on the VM:**
   ```bash
   docker build -t {project_name} -f Dockerfile .
   ```
4. **Run the container:**
   ```bash
   docker run -d --restart always -p {host_port}:{container_port} \
     -v /path/on/vm/static:/app/static \
     -v /path/on/vm/media:/app/media \
     -v /path/on/vm/.env:/app/.env \
     {project_name}
   ```

## Technologies Used

- Python 3.9
- Django 4.0.2
- Pillow 11.0.0
- python-dotenv 1.0.1
- Virtual Environment (venv)

## Hints

- Django settings can be customized in `babyshop_app/babyshop/settings.py` to match your specific environment.
- Check routing configurations in any `urls.py` file within `babyshop_app` to understand available endpoints.
- Always exclude sensitive data like `.env` from version control by adding it to `.gitignore`.
- For debugging, use `DEBUG=True` only in local environments. Never use it in production.

## Screenshots

### Home Page with Login

![Home Page with Login](https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080815407.jpg)

### Home Page with Filter

![Home Page with Filter](https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080840305.jpg)

### Product Detail Page

![Product Detail Page](https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080934541.jpg)

### Home Page without Login

![Home Page without Login](https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323080953570.jpg)

### Register Page

![Register Page](https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323081016022.jpg)

### Login Page

![Login Page](https://github.com/MET-DEV/Django-E-Commerce/blob/master/project_images/capture_20220323081044867.jpg)

## Conclusion

This project serves as a comprehensive example of how to build a scalable e-commerce platform using Django. It demonstrates critical concepts like environment-specific configurations, containerization with Docker, and deployment best practices. By following the steps outlined in this documentation, developers can set up, run, and extend the application to suit their needs. For further inquiries or contributions, feel free to open an issue or submit a pull request.
