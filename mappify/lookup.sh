#!/usr/bin/env bash
set -e

APIKEY="e49f5218-a980-4c60-8833-2e231906bf9f"

# url="http://mappify.io/api/rpc/coordinates/classify"
FILE="SoP.csv"

echo > output.txt

IFS=","
while read ip postcode thing lat lng; do

    lng="${lng//[$'\r\n ']}"
    echo
    echo "getting [$lat], [$lng]..."
    content="$( curl 'http://mappify.io/api/rpc/coordinates/classify'  -H 'Content-Type: application/json'  --data-binary "{\"lat\": $lat, \"lon\": $lng, \"encoding\": \"POA\", \"apiKey\": \"e49f5218-a980-4c60-8833-2e231906bf9f\" }" )"

    # echo "\n---\n$content\n---\n"
    # echo "\n---\n`echo \"$content\" | jq .result.code`\n---\n"

    echo "$ip, $postcode, $thing, $lat, $lng, `echo \"$content\" | jq .result.code`" >> output.txt
    echo

done < $FILE