#!/bin/bash
# Author: heltayb@student.42abudhabi.ae

# Big ASCII FLUSH title
ascii_flush() {
cat << "EOF"
   ______ _      _    _  _____ _    _ 
  |  ____| |    | |  | |/ ____| |  | |
  | |__  | |    | |  | | |    | |__| |
  |  ___|| |    | |  | | |___ | |__| |
  | |    | |____| |__| |____| | |  | |
  |_|    |______|______|\_____|_|  |_|

EOF
}

# Fancy intro animation
spin() {
	local chars=('/' '-' '\' '|')
	local delay=0.1
	for i in {0..15}; do
		printf "\r\033[36m[Loading FLUSH... %s]\033[0m" "${chars[$((i % 4))]}"
		sleep $delay
	done
	echo -e "\r\033[36m[FLUSH Ready!    ]\033[0m"
}

# Animated flush sequence
big_flush_animation() {
	local frames=(
		"[ FLUSHING █░░░░░░░░░░ ]"
		"[ FLUSHING ███░░░░░░░ ]"
		"[ FLUSHING █████░░░░░ ]"
		"[ FLUSHING ███████░░░ ]"
		"[ FLUSHING █████████░ ]"
		"[ FLUSHING ██████████ ]"
		"[ 💥 SUPER FLUSH COMPLETE 💥 ]"
	)
	for frame in "${frames[@]}"; do
		printf "\r\033[1;35m%s\033[0m" "$frame"
		sleep 0.3
	done
	echo ""
}

flush_animation() {
	local frames=(
		"[ FLUSHING █░░░░░░░░░░ ]"
		"[ FLUSHING ███░░░░░░░ ]"
		"[ FLUSHING █████░░░░░ ]"
		"[ FLUSHING ███████░░░ ]"
		"[ FLUSHING █████████░ ]"
		"[ FLUSHING ██████████ ]"
		"[ 💥 FLUSH COMPLETE 💥 ]"
	)
	for frame in "${frames[@]}"; do
		printf "\r\033[1;35m%s\033[0m" "$frame"
		sleep 0.3
	done
	echo ""
}

# Storage report with color label
print_storage() {
	local label=$1
	local color=$2
	local info=$(df -h "$HOME" | grep "$HOME")
	local total=$(echo "$info" | awk '{print $2}' | tr 'i' 'B')
	local avail=$(echo "$info" | awk '{print $4}' | tr 'i' 'B')

	[[ "$avail" == "0BB" ]] && avail="0B"
	[[ "$total" == "0BB" ]] && total="0B"

	echo -e "$color\n -- $label :\n    >> Total : $total\n    >> Available : $avail\033[0m"
}

# Script start
clear
ascii_flush
echo -e "\n       🧼 \033[1;32mWELCOME TO FLUSH 42\033[0m 🧼"
spin
sleep 1

should_log=0
[[ "$1" == "-p" || "$1" == "--print" ]] && should_log=1

print_storage "Storage Before Cleaning" "\033[1;33m"

function flush {
	[ -z "$1" ] && return 0
	[ $should_log -eq 1 ] && for arg in "$@"; do du -sh "$arg" 2>/dev/null; done
	/bin/rm -rf "$@" &>/dev/null
	return 0
}

function clean {
	shopt -s nullglob
	flush_animation

	flush "$HOME"/Library/*.42*
	flush "$HOME"/*.42*
	flush "$HOME"/.zcompdump*
	flush "$HOME"/.cocoapods.42_cache_bak*
	flush "$HOME"/.Trash/*
	/bin/chmod -R 777 "$HOME"/Library/Caches/Homebrew &>/dev/null
	flush "$HOME"/Library/Caches/*
	flush "$HOME"/Library/Application\ Support/Caches/*

	flush "$HOME"/Library/Application\ Support/Slack/Service\ Worker/CacheStorage/*
	flush "$HOME"/Library/Application\ Support/Slack/Cache/*
	flush "$HOME"/Library/Application\ Support/discord/Cache/*
	flush "$HOME"/Library/Application\ Support/discord/Code\ Cache/js*
	flush "$HOME"/Library/Application\ Support/discord/Crashpad/completed/*
	flush "$HOME"/Library/Application\ Support/Code/Cache/*
	flush "$HOME"/Library/Application\ Support/Code/CachedData/*
	flush "$HOME"/Library/Application\ Support/Code/Crashpad/completed/*
	flush "$HOME"/Library/Application\ Support/Code/User/workspaceStorage/*
	flush "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Service\ Worker/CacheStorage/*
	flush "$HOME"/Library/Application\ Support/Google/Chrome/Default/Service\ Worker/CacheStorage/*
	flush "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/Application\ Cache/*
	flush "$HOME"/Library/Application\ Support/Google/Chrome/Default/Application\ Cache/*
	flush "$HOME"/Library/Application\ Support/Google/Chrome/Crashpad/completed/*

	flush "$HOME"/Library/Application\ Support/Chromium/Default/File\ System
	flush "$HOME"/Library/Application\ Support/Chromium/Profile\ [0-9]/File\ System
	flush "$HOME"/Library/Application\ Support/Google/Chrome/Default/File\ System
	flush "$HOME"/Library/Application\ Support/Google/Chrome/Profile\ [0-9]/File\ System

	flush "$HOME"/Desktop/Piscine\ Rules\ *.mp4
	flush "$HOME"/Desktop/PLAY_ME.webloc
	flush "$HOME"/Desktop/**/*/.DS_Store

	# VS Code
	flush "$HOME"/Library/Application\ Support/Code/CachedData/*
}

clean

[ $should_log -eq 1 ] && echo
sleep 1
print_storage "Storage After Cleaning" "\033[1;36m"

# Ask for super flush
echo -e "\n⚠️  \033[1;31mWARNING:\033[0m Keychain files may contain important login data."
echo -e "   If you're absolutely sure you want to delete them, type: \033[1;33myes\033[0m"
read -rp $'\n> ' user_input

if [[ "$user_input" == "yes" ]]; then
	echo -e "\n\033[1;35m🔥 Initiating Super Flush...\033[0m"
	big_flush_animation
	echo -e "\n\033[1;31mDeleting Keychain files...\033[0m"
	flush "$HOME"/Library/Keychains/*
	sleep 1
	print_storage "Storage After Keychain Flush" "\033[1;35m"
else
	echo -e "\n\033[2mSkipped deleting Keychains.\033[0m"
fi

# Outro
echo -e "\n\033[1;36m   ✅ Cleaning Completed Successfully!\033[0m"
echo -e "   For any issues or feedback:"
echo -e "   📧 \033[4;1;34mheltayb@student.42abudhabi.ae\033[0m\n"
