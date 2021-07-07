
installGit() 
{
    sudo apt install git
}

installinstallPython() 
{
    sudo apt install python
}

checkGit() 
{
    echo "checking if git exists..."
    
    if ! type "git" > /dev/null; then
                
        read -r -p "Do you whant to install git? [y/N] " response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            installGit
        else
            echo "Can't continue with out git."
            echo "Build procces exited."
            exit
        fi
    fi

    echo "git exists"
}

checkPython() 
{
    echo "checking if python exists..."
    
    if ! type "python" > /dev/null; then
                
        read -r -p "Do you whant to install python? [y/N] " response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            installPython
        else
            echo "Can't continue with out python."
            echo "Build procces exited."
            exit
        fi
    fi

    echo "python exists"
}

installDependenciesAndStart()
{
    sudo pip install virtualenv

    virtualenv venv

    . venv/bin/activate

    pip install testresources

    pip install -r requirements.txt
    
    python manage.py db init
    python manage.py db migrate
    python manage.py db upgrade

    python manage.py runserver
}

updateSystem()
{
    read -r -p "Do you whant to update packages (RECOMENDED)? [y/N] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
        sudo apt update     
        sudo apt upgrade
        sudo apt full-upgrade  
        sudo apt autoremove 
    fi
}

build()
{
    echo "cloning..."
    
    git clone https://github.com/slurp-co/shortcuts-API

    cd shortcuts-API

    installDependenciesAndStart
}

main() 
{
    updateSystem
    checkGit
    build

    echo "Instructions:"

    echo "To install dependencies: 'pip i -r requirements.txt'"
    echo "To run the program: python manage.py runserver"
    echo "To activate virtualenv: source venv/bin/activate"
}

main