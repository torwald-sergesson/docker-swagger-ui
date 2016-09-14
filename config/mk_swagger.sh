#!/bin/bash

SRC_SWAGGER_FILE="/src/swagger/main.yaml"
TMP_SWAGGER_FILE=".swagger.json"
OUTPUT_FOLDER="/home/www/swaggers"
OUTPUT_SWAGGER_FILE="$OUTPUT_FOLDER/swagger.yaml"
ERROR_TEMPLATE="ErrorTemplate.yaml"

VALIDATION_MESSAGE=`swagger validate "${SRC_SWAGGER_FILE}" 2>&1`
IS_VALID=`echo ${VALIDATION_MESSAGE} | grep "is valid"`

if [ ! -n "$IS_VALID" ]; then
  echo "Validation error"
  echo "Generat error report"
  cat $ERROR_TEMPLATE > $OUTPUT_SWAGGER_FILE
  echo "$VALIDATION_MESSAGE" | sed -e "s/^/    /" >> $OUTPUT_SWAGGER_FILE
  exit 1;
fi

echo "Compiling Swagger file"
swagger bundle -o "$TMP_SWAGGER_FILE" "$SRC_SWAGGER_FILE"
json2yaml -d 15 "$TMP_SWAGGER_FILE" > "$OUTPUT_SWAGGER_FILE"
echo "Remove temp file"
rm "$TMP_SWAGGER_FILE"

echo "Creates file with versioned copy"
SWAGGER_VERSION=`grep "  version: " "$OUTPUT_SWAGGER_FILE" | grep -o -e "[0-9.]*"`
VERSIONED_FILE="$OUTPUT_FOLDER/swagger-$SWAGGER_VERSION.yaml"
cp "$OUTPUT_SWAGGER_FILE" "$VERSIONED_FILE"

echo "Finish"

