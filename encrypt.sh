#! /bin/bash
#=========================================================
#Created By: Brandon Cochrane, Technical Architect, Salesforce
#Last Updated: Jul 26 2023
#
#==============README=====================================
#Purpose if this script is to simplify the encryption and decryption of mMulesoft properties. 
#The script can handle encrypting and decrypting files and strings depending on the parameter set.
#
#HOW TO USE - 
# 1. place this script in the same folder as the secure-properties-tool.jar
# 2. run the script through the terminal with the sh command and follow the prompts
#
# HINT: Copy this file for different clients, environments and update the defaults to speed up the encryption and decryption processes depending on context
# you can update the defaults by changing the ${METHOD:-<value>} set at different stages
# It is also a good idea, if you change the default values, to also update the prompt, so you know what is being set if you run the default config. 
#=========================================================

echo "Values in [] brackets are defaults for the prompt. Press enter to use the default." 
#example command = java -cp secure-properties-tool.jar com.mulesoft.tools.SecurePropertiesTool string encrypt Blowfish CBC mulemulemulemule encryptThisString

#beginning string
BEGIN="java -cp secure-properties-tool.jar com.mulesoft.tools.SecurePropertiesTool "
#set method options are: string, file
read -p "What is the method? ([string], file(f)): " METHOD
METHOD=${METHOD:-string}

if [ $METHOD == "f" ]
then
    METHOD="file"
fi
#set operation options are: encrypt, decrypt
read -p "What is the operation? ([encrypt], decrypt(d)): " OPERATION
OPERATION=${OPERATION:-encrypt}

if [ $OPERATION == "d" ]
then
    OPERATION="decrypt"
fi

#set algorithm options: AES is default
read -p "What is the algorithm? ([AES], Blowfish, RSA, Camellia, CAST5, CAST6, DES, DESede, Noekeon, RC2, RC5, RC6, Rijndael, SEED, Serpent, Skipjack, TEA, Twofish, XTEA): " ALGORITHM
ALGORITHM=${ALGORITHM:-AES}

#set mode options: CBC is default
read -p "What is the mode? ([CBC], CFB, ECB, OFB): " MODE
MODE=${MODE:-CBC}

#set key options: KEY must be 16 characters long to work properly
read -p "What is the key? [mulemulemulemule]: " KEY
KEY=${KEY:-mulemulemulemule} #sets default value if one wasn't provided by user

#set value options: user defined string, or filename
read -p "What is the $METHOD to $OPERATION?" VALUE

#
TARGET=""

if [ $METHOD == "file" ]
then
    read -p "What is the output file name? " TARGET
fi

#set command
COMMAND="$BEGIN $METHOD $OPERATION $ALGORITHM $MODE $KEY $VALUE $TARGET"
echo $COMMAND
RESULT=$($COMMAND) 

#write result to terminal and copy it to clipboard.
echo $RESULT

if [ $METHOD == "file" ]
then
    echo $TARGET | tr -d '\n' | pbcopy 
    echo "output filename copied to clipboard"  
    
else
    echo $RESULT |  tr -d '\n' | pbcopy
    echo $OPERATION"ed value copied to clipboard"

fi

