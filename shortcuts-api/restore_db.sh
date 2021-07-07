
NO_FORMAT="\033[0m"
F_BOLD="\033[1m"
F_UNDERLINED="\033[4m"
C_GOLD3="\033[38;5;142m"
echo "${F_BOLD}${F_UNDERLINED}${C_GOLD3}WARING: this file should be at root folder${NO_FORMAT}"

. venv/bin/activate

sudo rm shortcuts.db
sudo rm -rf migrations
python manage.py db init
python manage.py db migrate
python manage.py db upgrade