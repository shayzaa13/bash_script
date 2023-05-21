function sign {
    local gpg_id="$1"
    
     git config --global user.signingkey "$gpg_id"
  git config --global commit.gpgsign true

    gpg --armor --export $gpg_id
    echo "now copy paste this key in your github account"
}




input=-1

while [[ $input != 0 ]]
do
echo "Enter a number from 0 to 3"
echo "0 to exit"
echo "1 to generate new gpg key"
echo "2 to remove old gpg key"
echo "3 to select one out of many gpg keys and make it a signing key"
gpg --list-secret-keys
read input 
if [ $input == 1 ]
then 
 gpg --full-generate-key
  gpg_id=$(gpg --list-secret-keys --keyid-format=long | awk '$1 ~ /sec/ { print $2 }' | cut -d'/' -f2 | tail -n 1)
sign "$gpg_id"


elif [ $input == 2 ]
then 
echo "enter gpg id of the key you want to remove"
read id
gpg --delete-secret-key $id
gpg --delete-key $id


elif [ $input == 3 ]
then
#signing

echo "enter the gpg id of the key you want to sign"
read gpgkeyid
sign "$gpgkeyid"

else
echo "Enter a number in the given range"
fi
done

