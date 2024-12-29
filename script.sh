USER=sansrati
SITE_NAME=toothytales
DB_USER=root
DB_PASS=tales@123!


# Create a new user and follow prompts
adduser $USER

# Add user to superuser group to unlock admin privileges
usermod -aG sudo $USER

# Then log in as the new user
su - $USER

# Update package lists
sudo apt-get update

# Update installed packages
sudo apt-get upgrade

# Install NGINX
sudo apt-get install nginx
sudo ufw allow 'Nginx Full'

# Install MySQL
sudo apt-get install mysql-server

# Enter mysql
sudo mysql
# Update permissions
ALTER USER $DB_USER@'localhost' IDENTIFIED WITH 'mysql_native_password' BY $DB_PASS;
# Reread permissions
FLUSH PRIVILEGES;
# exit mysql
exit

# Download and import the Nodesource GPG key
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

# Create deb repository
NODE_MAJOR=18 # Use a supported version
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

# Run update and install
sudo apt-get update
sudo apt-get install nodejs -y

# Install Ghost CLI
sudo npm install ghost-cli@latest -g

# Create directory: Change `sitename` to whatever you like
sudo mkdir -p /var/www/$SITE_NAME

# Set directory owner: Replace <user> with the name of your user
sudo chown $USER:$USER /var/www/$SITE_NAME

# Set the correct permissions
sudo chmod 775 /var/www/$SITE_NAME

# Then navigate into it
cd /var/www/$SITE_NAME

# Install Ghost in the folder
ghost install
