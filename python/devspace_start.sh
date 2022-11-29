#!/bin/bash
set +e  # Continue on errors

pip install -r requirements.txt

echo '
COLOR_CYAN="\033[0;36m"
COLOR_RESET="\033[0m"
COLOR_BLUE="\033[0;94m"
COLOR_GREEN="\033[0;92m"

# Set terminal prompt
export PS1="\[${COLOR_BLUE}\]devspace\[${COLOR_RESET}\] ./\W \[${COLOR_BLUE}\]\\$\[${COLOR_RESET}\] "
if [ -z "$BASH" ]; then export PS1="$ "; fi

# Include projects bin/ folder in PATH
export PATH="./bin:$PATH"

alias logs="tail -F /.devspace/screenlog.0"
alias restart="PID=$(cat /.devspace/devspace-pid) && rm /.devspace/devspace-pid && kill -9 -$PID"

echo -e "${COLOR_BLUE}
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
- App is running in the background,\`${COLOR_BLUE}ps -ef | grep python${COLOR_RESET}\`
- Use \`${COLOR_BLUE}logs${COLOR_RESET}\` command to stream App Logs
- Some ports will be forwarded, so you can access this container via ${COLOR_BLUE}localhost:${LOCAL_PORT}${COLOR_RESET}
"' >> ~/.bashrc

# Open shell
bash