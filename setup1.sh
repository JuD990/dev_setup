echo -n "Admin password required: "
read -rs PASSWORD
echo -e "\nVerifying..."

if echo "$PASSWORD" | sudo -S -v >/dev/null 2>&1; then
    echo "READY: Authentication Successful."

    # Example logic using all identified info:
    if [ "$DE_NAME" == "KDE Plasma" ] && [ "$SESSION" == "wayland" ]; then
        echo "Tip: Use 'kscreen-doctor' for monitor settings."
    fi
else
    echo "ERROR: Incorrect password."
    exit 1
fi

echo "Welcome Back!, $USER"

echo -e "Identifying Distro..\n"
if command -v pacman >/dev/null 2>&1; then
    DISTRO="Arch-based (uses pacman)"
    PACKAGE="pacman"
    if command -v yay >/dev/null 2>&1; then
    	echo -e "Distro uses yay"
	PACKAGE="yay"
    else
	echo -e "Does not have yay package"
    fi
elif command -v apt-get >/dev/null 2>&1; then
    DISTRO="Debian-based (uses apt)"
elif command -v dnf >/dev/null 2>&1; then
    DISTRO="RHEL/Fedora-based (uses dnf)"
elif command -v yum >/dev/null 2>&1; then
    DISTRO="RHEL-based (uses yum)"
else
   DISTRO="Unknown Linux"
fi

if [ -f /etc/os-release ]; then
    source /etc/os-release
    echo "Distro ID: $ID"
    echo "Full Name: $PRETTY_NAME"
    echo "Version:   $VERSION_ID"
else
    echo "Unidentified Distro."
fi

CURRENT_DE=$(echo "$XDG_CURRENT_DESKTOP" | tr '[:upper:]' '[:lower:]')

if [[ "$CURRENT_DE" == *"kde"* ]]; then
    DE_NAME="KDE Plasma"
elif [[ "$CURRENT_DE" == *"gnome"* ]]; then
    DE_NAME="GNOME"
elif [[ "$CURRENT_DE" == *"xfce"* ]]; then
    DE_NAME="XFCE"
else
    DE_NAME="Other/Custom ($XDG_CURRENT_DESKTOP)"
fi

# 3. Identify Session Type
SESSION=$XDG_SESSION_TYPE

echo "Distro:  $DISTRO"
echo "Desktop: $DE_NAME"
echo "Session: $SESSION"
