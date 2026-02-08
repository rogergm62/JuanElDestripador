#!/bin/bash

# CIS 450 Pen Testing. Rogelio G.
#This script automates the use of John the Ripper and Hashcat
# It finds and tests several wordlists located in "seclist."

# ************ JOHN THE RIPPER *****************************
# If you want to delete the stored passwords uncommnet the following line:
rm ~/.john/john.pot

# The following line is where the hashes are located
HASF="/home/kali/.msf4/loot/20260206155050_tyrell_192.168.1.142_windows.hashes_063985.txt"

# This is where the world lists are located, I recoment start with Common Credentials
# Using "seclists/Passwords" or just "/seclist" could be time-consuming.
# Verify the location of seclists. This is the default location using "apt install seclists."
# Or you can create a new folder with your favorite wordlist files
BASE="/usr/share/seclists/Passwords/Common-Credentials"

# This loop tests one wordlist after another:
for WORDLIST in $(find "$BASE" -type f -name "*.txt"); do
    echo "****** TRYING WORLIST: $WORDLIST"
    
    # Modify the format according to the type of hashes, e.g., NT or netntlmv2
    # I recommend starting with no rules, then try Korelogic, and finally Jumbo.
    time john --format=NT --rules=Jumbo --wordlist="$WORDLIST" "$HASF"
done
#
echo "Passwords"
john --show --format=NT "$HASF"

# ***************** HASHCAT *******************************

# Uncomment the next line to delete all stored passwords
rm ~/.hashcat/hashcat.potfile

# This loop tests one wordlist after another:
for WORDLIST in $(find "$BASE" -type f -name "*.txt"); do
    echo "****** TRYING WORLIST: $WORDLIST"
    
    # Modify the format according to the type of hashes, e.g., 1000 for NTLM or 5600 for NTLMv2
    # I recommend adding a wordlist plus a rule like best66 or rockyou-30000 to compare to Korelogic or Jumbo.
    # Check ls /usr/share/hashcat/rules/ for a complete list of rules
    time hashcat -m 1000 -a 0 "$HASF" "$WORDLIST" -r /usr/share/hashcat/rules/best66.rule
done
#
echo "Passwords"
hashcat -m 1000 --show "$HASF"
