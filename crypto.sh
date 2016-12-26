#!/bin/bash


function help {
  echo ""
  echo "Usage: ./crypto.sh [-d|-e] -i input.cfg -o output.xml"
  echo ""
  echo "Options:"
  echo "         -d | --decrypt        decrypt the default option"
  echo "         -e | --encrypt        encrypt"
  echo "         -h | --help           this page"
  echo "         -i | --input          input file (.cfg)"
  echo "         -o | --output         output file (.xml)"
  echo ""
  echo "Examples:"
  echo "decrypt with"
  echo "./crypto.sh -i conf.cfg -o conf.xml"
  echo "encrypt with"
  echo "./crypto.sh -e -i conf.xml -o conf.cfg"
  echo ""
}



while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -e|--encrypt)
    ENCRYPT=YES
    ;;
    -d|--decrypt)
    ENCRYPT=NO
    ;;
    -h|--help)
    HELP=YES
    ;;
    -i|--input)
    INPUT="$2"
    shift # past argument
    ;;
    -o|--ouput)
    OUTPUT="$2"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done


if [ "${HELP}" = YES ]; then
    help
else

  if [ -z ${INPUT} ]; then
     help
     echo "no input file defined. use -i or --input";
     echo
     exit
  fi
  if [ -z ${OUTPUT} ]; then
     help
     echo "no output file defined. use -o or --output";
     echo
     exit
  fi

  if [ "${ENCRYPT}" = YES ]; then
     echo "encrypting file ${INPUT} to file ${OUTPUT}"
     openssl aes-128-cbc -K a0dd1da4242d32424fdffaa0ed0e0f12 -nosalt -iv 0 -e -in ${INPUT} -out ${OUTPUT}
  else
    echo "decrypting file ${INPUT} to file ${OUTPUT}"
     openssl aes-128-cbc -K a0dd1da4242d32424fdffaa0ed0e0f12 -nosalt -iv 0 -d -in ${INPUT} -out ${OUTPUT}
  fi

fi


