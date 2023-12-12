# checking if the repo name was given
if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <remote-repo-name>"
	exit 1
fi

# getting current path
current_path=$(pwd)

# do not move forward if they're creating the repo in the home folder
home_path="$HOME"

if [ "$current_path" == "$home_path" ]; then
	echo "Warning: Cannot create local repo at $home_path, navigate to the correct directory"
	exit 1
fi

# double checking repo location with user
read -p "You are at $current_path, are you sure you would like to create the repo here? (y/n): " correct_path

# if they say anything else aart from "y", exit
if [[ $(echo "$correct_path" | tr '[:upper:]' '[:lower:]') != "y" ]]; then
	echo "Warning: Change directories and try again"
	exit 1
fi

# saving the repo name in a variable
repo_name=$1

# getting the token
TOKEN=$GITHUB_TOKEN

# creating a github repo
response=$(curl -L \
              -X POST \
              -H "Accept: application/vnd.github+json" \
              -H "Authorization: Bearer $TOKEN" \
              https://api.github.com/user/repos \
              -d "{\"name\":\"$repo_name\",\"private\":true}")

# getting the message
error_message=$(echo $response | jq -r '.message')

# if there's an error message, let the user know and exit
if [[ "$error_message" != "null" ]]; then
	# checking for specific errors
	specific_errors=$(echo $response | jq -r '.errors')

	# if there's a specific error message, print that
	if [[ ! -z $specific_errors ]]; then
		specific_error_message=$(echo $response | jq -r '.errors[0].message')
		echo "Error: $specific_error_message"
	else
		echo "Error: $error_message"
	fi

	exit 1
fi


# geting the url from the response
remote_url=$(echo $response | jq -r '.clone_url')
echo "URL: $remote_url"

# initialise the local repo
git init

# add all existing files to the staging area
git add .

# commit all the files added
git commit -m "Initial commit"

# add the remote repo
git remote add origin $remote_url

# push to the remote repo
git push -u origin main
