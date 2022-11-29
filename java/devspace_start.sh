#!/bin/bash
set +e  # Continue on errors

# wget https://devspace.eu-central-1.linodeobjects.com/java/.m2/settings.xml -P /root/.m2/

echo "Installing maven dependencies"
mvn -T 2C install

echo '
COLOR_CYAN="\033[0;36m"
COLOR_RESET="\033[0m"
COLOR_BLUE="\033[0;94m"
COLOR_GREEN="\033[0;92m"

# Set terminal prompt
export PS1="\[${COLOR_CYAN}\]devspace\[${COLOR_RESET}\] ./\W \[${COLOR_CYAN}\]\\$\[${COLOR_RESET}\] "
if [ -z "$BASH" ]; then export PS1="$ "; fi

# Include projects bin/ folder in PATH
export PATH="./bin:$PATH"

alias logs="tail -F /.devspace/screenlog.0"
alias restart="PID=$(cat /.devspace/devspace-pid) && rm /.devspace/devspace-pid && kill -9 -$PID"

echo -e "${COLOR_CYAN}
   ____              ____
  |  _ \  _____   __/ ___| _ __   __ _  ___ ___
  | | | |/ _ \ \ / /\___ \|  _ \ / _\ |/ __/ _ \\
  | |_| |  __/\ V /  ___) | |_) | (_| | (_|  __/
  |____/ \___| \_/  |____/| .__/ \__,_|\___\___|
                          |_|
${COLOR_RESET}
Welcome to your development container!

This is how you can work with it:
- Files will be synchronized between your local machine and this container
- App is running in the background,\`${COLOR_CYAN}ps -ef | grep java${COLOR_RESET}\`
- Use \`${COLOR_CYAN}logs${COLOR_RESET}\` command to stream App Logs
- Some ports will be forwarded, so you can access this container via ${COLOR_CYAN}localhost:${LOCAL_PORT}${COLOR_RESET}
"' >> ~/.bashrc

# Open shell
bash
