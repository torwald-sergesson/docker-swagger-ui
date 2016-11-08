#!/bin/bash

PROJECT_FOLDER="/home/project"
WWW_FOLDER="/home/www/swaggers"
LABEL="$1"
INPUT_FILE="$2"
OUTPUT_FILE="$3"
SRC_SWAGGER_FILE="$PROJECT_FOLDER/$INPUT_FILE"
TMP_SWAGGER_FILE=".swagger.json"
OUTPUT_SWAGGER_FILE="$PROJECT_FOLDER/$OUTPUT_FILE"
WWW_SWAGGER_FILE="$WWW_FOLDER/swagger-$LABEL.yaml"
ERROR_TEMPLATE="ErrorTemplate.yaml"

#echo "PROJECT_FOLDER: $PROJECT_FOLDER"
#echo "WWW_FOLDER: $WWW_FOLDER"
#echo "LABEL: $LABEL"
#echo "INPUT_FILE: $INPUT_FILE" 
#echo "OUTPUT_FILE: $OUTPUT_FILE"
#echo "SRC_SWAGGER_FILE: $SRC_SWAGGER_FILE"
#echo "TMP_SWAGGER_FILE: $TMP_SWAGGER_FILE"
#echo "OUTPUT_SWAGGER_FILE: $OUTPUT_SWAGGER_FILE"
#echo "WWW_SWAGGER_FILE: $WWW_SWAGGER_FILE"

echo "Build swagger for $LABEL ($INPUT_FILE)"

VALIDATION_MESSAGE=`swagger validate "${SRC_SWAGGER_FILE}" 2>&1`
IS_VALID=`echo ${VALIDATION_MESSAGE} | grep "is valid"`

if [ ! -n "$IS_VALID" ]; then
  echo "Validation error"
  echo "Generate error report"
  cat $ERROR_TEMPLATE > $WWW_SWAGGER_FILE
  echo "$VALIDATION_MESSAGE" | sed -e "s/^/    /" >> $WWW_SWAGGER_FILE
  exit 1;
fi

echo "Compiling Swagger file"
swagger bundle -o "$TMP_SWAGGER_FILE" "$SRC_SWAGGER_FILE"
json2yaml -d 15 "$TMP_SWAGGER_FILE" > "$WWW_SWAGGER_FILE"
echo "Remove temp file"
rm "$TMP_SWAGGER_FILE"

if [ $OUTPUT_FILE ]; then
  echo "Write down copy of swagger file"
  cp "$WWW_SWAGGER_FILE" "$OUTPUT_SWAGGER_FILE"
fi

echo "Finish"

