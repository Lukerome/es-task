#!/bin/bash

ES_IP=`kubectl get svc es-task-data-svc -o yaml | awk -F":" '/clusterIP:/ {print $2}'|tr -d ' '`

echo "curl -X GET -k "https://${ES_IP}:9200/sample-index/_count" -H "Content-Type: application/json" -u admin:admin -d'
{
  \"query\": {
    \"match\": {
      \"exif.make\": \"OnePlus\"
    }
  }
}'"

curl -X GET -k "https://${ES_IP}:9200/sample-index/_count" -H "Content-Type: application/json" -u admin:admin -d'
{
  "query": {
    "match": {
      "exif.make": "OnePlus"
    }
  }
}'

echo " "
echo " "
echo " "

echo "curl -X GET -k "https://${ES_IP}:9200/sample-index/_count" -H "Content-Type: application/json" -u admin:admin -d'
{
  \"query\": {
    \"match\": {
      \"file.name\": \"photo-6\"
    }
  }
}'"

curl -X GET -k "https://${ES_IP}:9200/sample-index/_count" -H "Content-Type: application/json" -u admin:admin -d'
{
  "query": {
    "match": {
      "file.name": "photo-6"
    }
  }
}'

echo " "
echo " "
echo " "
