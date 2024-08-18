#!/bin/bash

# Generate and sign file
echo "Auto-generated file" > ~/char1/cron_file.txt
gpg --sign --output ~/char1/cron_file.sig --detach-sig ~/char1/cron_file.txt

# Encrypt the file with the public key of charchit2
openssl rsautl -encrypt -inkey ~/.ssh/id_rsa_charchit2.pub -pubin -in ~/char1/cron_file.txt -out ~/char1/encrypted_file.enc

# Send to charchit2
scp ~/char1/encrypted_file.enc charchit2@kali:~/char2/

# Decrypt on charchit2
ssh charchit2@kali "openssl rsautl -decrypt -inkey ~/.ssh/id_rsa -in ~/char2/encrypted_file.enc -out ~/char2/decrypted_file.txt"
