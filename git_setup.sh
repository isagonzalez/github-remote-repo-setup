#!/bin/bash

VERSION="1.0.1"

# help function
show_help() {
	echo "Usage: gitsetup [repo-name] [-p | --public]"
	echo ""
	echo "Options:"
	echo "\trepo-name       Name of the GitHub repo (defaults to current directory name)"
	echo "\t-p, --public    Create a public repository (default is private)"
	echo "\t-h, --help      Show this help message"
	echo "\t-v, --version   Show the version number"
	exit 0
}

# defaults
repo_name=""
private_repo="true"
args=("$@")

# parse arguments
while [[ "$#" -gt 0 ]]; do
	case "$1" in
		-h|--help)
			show_help
			;;
		-p|--public)
			private_repo="false"
			;;
		-v|--version)
			echo "gitsetup $VERSION"
			exit 0
			;;
		-*)
			echo "❌ Unknown option: $1"
			echo "Run 'gitsetup --help' for usage information."
			exit 1
			;;
		*)
			if [[ -z "$repo_name" ]]; then
				repo_name="$1"
			else
				echo "❌ Unexpected argument: $1"
				echo "Run 'gitsetup --help' for usage information."
				exit 1
			fi
			;;
	esac
	shift
done

# if no repo name is provided
if [[ -z "$repo_name" ]]; then
	repo_name=$(basename "$PWD")
	echo "ℹ️  No repo name provided. Defaulting to current directory: '$repo_name'"
fi

# getting current path
current_path=$(pwd)
home_path="$HOME"

# do not move forward if they're creating the repo in the home folder
if [ "$current_path" == "$home_path" ]; then
	echo "⚠️ Cannot create repo in the home folder. Navigate to a project directory first."
	exit 1
fi

# double checking repo location with user
read -p "You are at $current_path. Would you like to create the repo here? (y/n): " correct_path

# if they say anything else apart from "y", exit
if [[ $(echo "$correct_path" | tr '[:upper:]' '[:lower:]') != "y" ]]; then
	echo "⚠️ Change directories and try again."
	exit 1
fi

# check for github token
if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "❌ GITHUB_TOKEN is not set in the environment."
	exit 1
fi

# creating a github repo
response=$(curl -L \
              -X POST \
              -H "Accept: application/vnd.github+json" \
              -H "Authorization: Bearer $GITHUB_TOKEN" \
              https://api.github.com/user/repos \
              -d "{\"name\":\"$repo_name\",\"private\":$private_repo}")

# check for errors
error_message=$(echo "$response" | jq -r '.message')
if [[ "$error_message" != "null" ]]; then
    specific_error=$(echo "$response" | jq -r '.errors[0].message // empty')
    if [[ -n "$specific_error" ]]; then
        echo "❌ GitHub API error: $specific_error"
    else
        echo "❌ GitHub error: $error_message"
    fi
    exit 1
fi

# geting the url from the response
remote_url=$(echo $response | jq -r '.clone_url')
echo "✅ GitHub repo created: $remote_url"

# initialise the local repo
git init -b main

# add all existing files to the staging area
git add .

# commit all the files added
git commit -m "Initial commit"

# add the remote repo
git remote add origin $remote_url

# push to the remote repo
git push -u origin main
