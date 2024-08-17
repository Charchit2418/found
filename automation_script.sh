#!/bin/bash

# Variables
USER1="sanskriti1"
USER2="sanskriti2"
HOME1="/home/$USER1/keys"
HOME2="/home/$USER2/keys"
SERVER="kali"

# Encrypt data for USER2
sudo -u $USER1 -i gpg --armor --encrypt --recipient $USER2@example.com $HOME1/file_to_sign.txt
sudo -u $USER1 -i gpg --armor --encrypt --recipient $USER2@example.com $HOME1/file_to_sign.txt.sig

# Transfer encrypted files to USER2 using SCP
scp $HOME1/file_to_sign.txt.asc $USER2@$SERVER:$HOME2/
scp $HOME1/file_to_sign.txt.sig.asc $USER2@$SERVER:$HOME2/

# On USER2's side: Decrypt files (this should be run on USER2's machine or after switching to USER2)
sudo -u $USER2 -i gpg --decrypt $HOME2/file_to_sign.txt.asc > $HOME2/decrypted_file_to_sign.txt
sudo -u $USER2 -i gpg --decrypt $HOME2/file_to_sign.txt.sig.asc > $HOME2/decrypted_file_to_sign.sig

# Verify the signature
sudo -u $USER2 -i gpg --verify $HOME2/decrypted_file_to_sign.sig $HOME2/decrypted_file_to_sign.txt
