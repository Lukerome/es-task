#!/bin/bash

ES_IP=`kubectl get svc es-task-data-svc -o yaml | awk -F":" '/clusterIP:/ {print $2}'| tr -d ' '`

curl -X PUT -k "https://${ES_IP}:9200/_index_template/sample_template" -H "Content-Type: application/json" -u admin:admin -d'
{
  "index_patterns": ["sample-index*"],
  "template": {
    "settings": {
      "number_of_shards": 3,
      "number_of_replicas": 1
    },
    "mappings": {
      "dynamic": false,
      "properties": {
        "ts": { "type": "date" },
        "gps": {
          "properties": {
            "location": { "type": "geo_point" }
          }
        },
        "file": {
          "properties": {
            "name": { "type": "keyword" },
            "ext": { "type": "keyword" },
            "size_bytes": { "type": "long" },
            "md5": { "type": "keyword" },
            "s3path": { "type": "keyword" },
            "width": { "type": "integer" },
            "height": { "type": "integer" }
          }
        },
        "exif": {
          "type": "object",
          "enabled": false
        },
        "faces": {
          "type": "nested",
          "properties": {
            "faceId": { "type": "keyword" },
            "attrs": { "type": "keyword" }
          }
        },
        "ocr": {
          "properties": {
            "lang": { "type": "keyword" },
            "text": { "type": "text" }
          }
        },
        "labels": {
          "properties": {
            "nsfw": {
              "properties": {
                "result": { "type": "keyword" }
              }
            }
          }
        }
      }
    }
  }
}
'
