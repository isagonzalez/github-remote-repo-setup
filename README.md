# GitHub Repository Creator

This script simplifies the process of creating a new private GitHub repository from your local directory. It automates the steps of initializing a Git repository, adding files, making an initial commit, and pushing it to GitHub.

## Usage

You can execute the script by running:
```bash
gitsetup my-new-repo
```

OR

```bash
/path/to/your/script/git_setup.sh my-new-repo
```

If you didn't set up the alias.

## How It Works

1. **Checking for Repository Name**: The script checks if you provide a repository name as an argument. If not, it will prompt you to provide one.

2. **Safety Check**: It verifies that you are not trying to create the repository in your home directory (for safety).

3. **Directory Confirmation**: You'll be prompted to confirm the directory where you want to create the repository. Make sure it's the correct location.

4. **GitHub Personal Access Token**: The script uses a GitHub Personal Access Token to create a new private repository on GitHub.

5. **GitHub Set Up**: The script initializes a local Git repository, adds all existing files, commits them, sets up the remote repository on GitHub, and it pushes your local repository to GitHub.

6. **Enjoy**: Your local repository is now linked to the newly created GitHub repository.

## Setup Instructions

1. **Download the Script**: Download the script file provided in this repo.

2. **Choose a Location**: Decide where you'd like to keep your scripts.
  -  I recommend creating a folder for scripts within your home folder.
  -  For Mac users, this is typically at /Users/your-username.

3. **Make the Script Executable**:
  - Open your terminal and navigate to the folder where you saved the script.
  - Run the command:

    ```bash
    chmod +x git_setup.sh
    ```
    
4. **Remember Your Script's Location**:
  - It's important to know where your script is located.
  - You can easily copy the path by opening terminal, navigating to the script's folder, and running `pwd`. Copy the results.
    
5. **Add the Script Directory to Your PATH**:
  - Open your shell's profile script in a text editor. For example: `open ~/.zshrc`.
    - Depending on your shell, it could be ~/.bashrc, ~/.bash_profile, or ~/.zshrc.
    - You can determine your shell by running echo `$SHELL` or `ps $$` in the terminal.
  - Copy and paste the following at the bottom of the file:

    ```bash
    # Adding my scripts folder export
    PATH="$PATH:/path/to/your/directory" 
    ```

  - Replace /path/to/your/directory with the path you copied in Step 4.
  - (Optional) Create an alias for the script for easier use. For Example:

    ```bash
    # Adding an alias for the git_setup script alias
    gitsetup='/path/to/your/directory/git_setup.sh'
    ```
   
6. **Get a GitHub Personal Access Token**:
   - [Generate a Personal Access Token on GitHub](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).
   - Make sure you check the box that says "repo"
     
7. **Add Your GitHub Token to the Shell Profile:
   - Open your shell's profile script again.
   - Add the following line at the end of the file:
  
     ```bash
     # GitHub personal access token with repo access
     export GITHUB_TOKEN="your-token-goes-here"
     ```
     
   - Replace `your-token-goes-here` with the token you made in Step 6.
   
8. **Reload Your Shell Profile**:
  - Run the appropriate command to reload your shell profile script, depending on your shell. For example: `source ~/.zshrc`

Happy coding!
