
installGit() 
{
    sudo apt install git
}

installYarn() 
{
    sudo apt install yarn
}

installNpm() 
{
    sudo apt install npm
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

installDependenciesNpm()
{
    echo "checking if npm exists..."
    
    if ! type "npm" > /dev/null; then
                
        read -r -p "Do you whant to install npm? [y/N] " response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            installNpm
            npm i
            npm start
        else
            echo "Can continue with out yarn or npm"
        fi
    else
        npm i
        npm start
    fi
}

installDependenciesAndStart()
{
    echo "checking if yarn exists..."
    
    if ! type "yarn" > /dev/null; then
                
        read -r -p "Do you whant to install yarn? [y/N] " response
        if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
            installYarn
            yarn
            yarn start
        else
            installDependenciesNpm
        fi
    
    else
        yarn
        yarn start
    fi
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
    
    git clone https://github.com/slurp-co/search

    cd search

    installDependenciesAndStart
}

main() 
{
    updateSystem
    checkGit
    build

    echo "Instructions:"

    echo "To install dependencies: 'yarn' or 'npm i'"
    echo "To run the program: 'yarn start' or 'npm start'"
}

main