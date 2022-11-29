#!/bin/bash
set +e  # Continue on errors

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

alias logs="tail -F /.devspace/screenlog.0"' >> ~/.bashrc

source ~/.bashrc

echo -e "${COLOR_CYAN}
   ____              ____
  |  _ \  _____   __/ ___| _ __   __ _  ___ ___
  | | | |/ _ \ \ / /\___ \| '_ \ / _\` |/ __/ _ \\
  | |_| |  __/\ V /  ___) | |_) | (_| | (_|  __/
  |____/ \___| \_/  |____/| .__/ \__,_|\___\___|
                          |_|
${COLOR_RESET}

Welcome to your development container!

This is how you can work with it:
- Files will be synchronized between your local machine and this container
- Some ports will be forwarded, so you can access this container via localhost
- Run \`${COLOR_BLUE}python main.py${COLOR_RESET}\` to start the application
"

# Open shell
bash --norc
