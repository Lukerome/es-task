#!/bin/bash
ES_IP=`kubectl get svc es-task-data-svc -o yaml | awk -F":" '/clusterIP:/ {print $2}'| tr -d ' '`

curl -X POST -k "https://${ES_IP}:9200/sample-index/_doc" -H "Content-Type: application/json" -u admin:admin -d'
{
  "ts": "2022-08-29T15:19:52Z",
  "gps": {
    "location": { "lat": 24.919737, "lon": 55.002941 }
  },
  "file": {
    "name": "photo-6",
    "ext": ".jpg",
    "size_bytes": 1778799,
    "md5": "68d0fb558306b291a871bea42c9fe6b8",
    "s3path": "s3://bucket/qa-test-images/EXPORT/Location/Location/oneplus/photo-6.jpg",
    "width": 4000,
    "height": 3000
  },
  "exif": {
    "make": "OnePlus",
    "model": "GM1910",
    "orientation": "Top, left side (Horizontal / normal)",
    "datetime_original": "2022-05-02T16:27:56",
    "datetime_digitized": "2022-05-02T16:27:56",
    "datetime": "2022-05-02T16:27:56",
    "image_width": 4000,
    "image_height": 3000,
    "x_resolution_dpi": 72.0,
    "y_resolution_dpi": 72.0,
    "resolution_unit": "Inch",
    "exposure_time_s": 0.02,
    "shutter_speed_value": "1/49 sec",
    "exposure_program": "Program normal",
    "exposure_mode": "Auto exposure",
    "exposure_bias_ev": 0.0,
    "f_number": 1.6,
    "aperture_value": 1.6,
    "max_aperture_value": 1.6,
    "iso": 640,
    "flash": "Flash did not fire",
    "flashpix_version": "1.00",
    "white_balance": "D65",
    "white_balance_mode": "Auto white balance",
    "metering_mode": "Spot",
    "color_space": "sRGB",
    "components_configuration": "YCbCr",
    "sensing_method": "(Not defined)",
    "scene_capture_type": "Standard",
    "scene_type": "Directly photographed image",
    "focal_length_mm": 4.8,
    "focal_length_35mm": 27,
    "subsec_time": "531132",
    "subsec_time_original": "531132",
    "subsec_time_digitized": "531132"
  },
  "faces": [
    {
      "faceId": "c12b17f4-026a-45f5-ab82-70fe98c06c71",
      "attrs": ["Blurry", "Male", "No Beard"]
    },
    {
      "faceId": "f2abc6dc-0928-470d-bd8a-52bd94d07dcb",
      "attrs": ["Blurry", "Male", "Beard"]
    }
  ],
  "ocr": {
    "lang": ["ara", "eng"],
    "text": "فاتورة Invoice 123 — المجموع Total 250 AED، الرجاء الدفع خلال 7 أيام. Thank you شكراً."
  },
  "labels": {
    "nsfw": {
      "result": "SFW"
    }
  }
}
'

