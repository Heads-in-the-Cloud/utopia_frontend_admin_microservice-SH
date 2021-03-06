FROM utopia_frontend_base_image

LABEL maintainer="sean.horner@smoothstack.com"
LABEL project="utopia_airlines"

# Changing working directory to the system user's home repository
WORKDIR /home/utopian/app
# Copying the necessary files into the application folder
COPY templates templates
COPY                \
# From context
    app.py          \
    boot.sh         \
    config.py       \
    forms.py        \
    networking.py   \
    routes.py       \
    tests.py        \
# To working directory
    ./

# Ensuring that the entry_script has execution permissions
RUN chmod +x boot.sh

# Setting the FLASK_APP environmental variable
ENV FLASK_APP app.py

# Setting the SECRET_KEY environmental variable to it's secrets mount location
ENV SECRET_KEY /run/secrets/utopia_secret_key

# Ensuring that the system user has the appropriate permissions to run the application
RUN chown -R utopian:utopian ./
# Switching to the system user to run the image
USER utopian

# Exposing port 5000 for Flask interactions
EXPOSE 5000

# Setting the entry_script as the image's entrypoint
ENTRYPOINT ["./boot.sh"]
