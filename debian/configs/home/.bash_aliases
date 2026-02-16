runInNewTab() {
	# $1 = command to run (string).
	gnome-terminal --tab --hold -- bash -c $1
}

# shows current git branch
parse_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\u@\h \[\e[32m\]\w \[\e[91m\]\$(parse_git_branch)\[\e[00m\]$ "

alias ls='ls -lh -alF --color=auto'
alias maintenance='sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean && sudo snap refresh'

alias bundletool='java -jar /home/tom/Documents/bundletool-all-1.8.2.jar'
alias stirling='sudo java -jar ~/Documents/Stirling-PDF/Stirling-PDF.jar'

# ravkav-store
ravkav_store_dir="~/src/ravkav-store"
ravkav_store_client_dir="~/src/ravkav-store/client"
alias staging_ro="bash ${ravkav_store_dir}/blackhole/staging.sh RAVKAVONLINE"
alias staging_ao="bash ${ravkav_store_dir}/blackhole/staging.sh ALHAKAVONLINE"
alias production_ro="bash ${ravkav_store_dir}/blackhole/production.sh RAVKAVONLINE"

# mobiride
mobiride_dir="~/src/mobiride"
alias staging_mo="bash "${mobiride_dir}"/blackhole/staging.sh"
alias production_mo="bash "${mobiride_dir}"/blackhole/production.sh"

weather() {
	curl -s "wttr.in/$1?m1"
}

toggler_invalid_param_output() {
	local color_red="\e[1;31m"
	local color_green="\e[1;32m"
	local color_end="\e[0m"
	echo -e "${color_red}Invalid parameter:${color_end} valid options are ${color_green}\"on\"${color_end} | ${color_green}\"off\"${color_end}."
}

nightlight() {
	if [[ "$1" == "on" ]]; then
		gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
		echo Nightlight enabled
	elif [[ "$1" == "off" ]]; then
		gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled false
		echo Nightlight disabled
	else
		toggler_invalid_param_output
	fi
}

touchpad() {
	if [[ "$1" == "on" ]]; then
		gsettings set org.gnome.desktop.peripherals.touchpad send-events enabled
		echo Touchpad enabled
	elif [[ "$1" == "off" ]]; then
		gsettings set org.gnome.desktop.peripherals.touchpad send-events disabled
		echo Touchpad disabled
	else
		toggler_invalid_param_output
	fi
}

sleepmode() {
	if [[ "$1" == "on" ]]; then
		sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
		echo Sleep enabled
	elif [[ "$1" == "off" ]]; then
		sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
		echo Sleep disabled
	else
		toggler_invalid_param_output
	fi
}
