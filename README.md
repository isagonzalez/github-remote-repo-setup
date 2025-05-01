# GitHub Repository Creator - `gitsetup`

This script simplifies the process of creating a new GitHub repository from your local directory. It automates the steps of initializing a Git repository, adding files, making an initial commit, and pushing it to GitHub.

---

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

---

## Installation (Recommended)

You can install the script automatically using the following command:

```bash
curl -s https://raw.githubusercontent.com/isagonzalez/github-remote-repo-setup/main/install.sh | bash
```

This will:

- Download the script to `~/.local/bin`
- Add it to your shell's `$PATH` (if it's not already)
- Let you run `gitsetup` from any terminal window

After installation, run:

```bash
source ~/.zshrc
```

---

## Updating

To update to the latest version, just re-run the install command:

```bash
curl -s https://raw.githubusercontent.com/isagonzalez/github-remote-repo-setup/main/install.sh | bash
```

---

## How It Works

1. **Checking for Repository Name**: The script checks if you provide a repository name as an argument. If not, it will ise your current folder name as the default.

2. **Safety Check**: It verifies that you are not trying to create the repository in your home directory (for safety).

3. **Directory Confirmation**: You'll be prompted to confirm the directory where you want to create the repository. Make sure it's the correct location.

4. **GitHub Personal Access Token**: The script uses a GitHub Personal Access Token to create a new private repository on GitHub.

5. **GitHub Set Up**: The script initializes a local Git repository, adds all existing files, commits them, sets up the remote repository on GitHub, and it pushes your local repository to GitHub.

6. **Enjoy**: Your local repository is now linked to the newly created GitHub repository.

---

## Manual Setup Instructions

1. **Download the Script**: Download the script file provided in this repo.

2. **Choose a Location**: Use the recommended directory for user-installed scripts:

- Save the script to `~/.local/bin`
- For Mac users, this is typically at `/Users/your-username/.local/bin`

3. **Make the Script Executable**:

- Open your terminal and navigate to the folder where you saved the script.
- Run the command:

  ```bash
  chmod +x git_setup.sh
  ```

4. **Move the Script to Your Local Bin** (if not already saved there):

```bash
mv git_setup.sh ~/.local/bin/gitsetup
```

5. **Ensure the Directory Is in Your PATH**:

- Open your shell's profile script in a text editor. For example: `open ~/.zshrc`.
  - Depending on your shell, it could be `~/.bashrc`, `~/.bash_profile`, or `~/.zshrc`.
  - You can determine your shell by running `echo $SHELL` or `ps $$` in the terminal.
- Add the following line at the bottom of the file if it's not already present:

  ```bash
  export PATH="$PATH:$HOME/.local/bin"
  ```

6. (Optional) **Create an Alias** (only if you didn’t rename it to `gitsetup`):

```bash
alias gitsetup="$HOME/.local/bin/git_setup.sh"
```

7. **Get a GitHub Personal Access Token**:

   - [Generate a Personal Access Token on GitHub](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token).
   - Make sure you check the box that says "repo"

8. **Add Your GitHub Token to the Shell Profile**:

- Open your shell's profile script again.
- Add the following line at the end of the file:

  ```bash
  # GitHub personal access token with repo access
  export GITHUB_TOKEN="your-token-goes-here"
  ```

- Replace `your-token-goes-here` with the token you made in Step 7.

9. **Reload Your Shell Profile**:

- Run the appropriate command to reload your shell profile script, depending on your shell. For example: `source ~/.zshrc`

Happy coding!
