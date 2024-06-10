#!/bin/bash

# Configurazione delle variabili
GLPI_INSTANCE_URL="https://magic.smeupics.cloud"
USER_TOKEN="CXRI0DbnD0N2tJozWpuRIqUuQX9kV2ZgsIChJdCv"
APP_TOKEN="NHSPoJRnr7mF0gkdlZWTDCGsdWSL9bw1SDTcwbLp"
#USERNAME="your-username"
#PASSWORD="your-password"

curl -X POST "$GLPI_INSTANCE_URL/apirest.php/initSession" \
-H "Content-Type: application/json" \
-H "Authorization: user_token $USER_TOKEN" \
-H "App-Token: $APP_TOKEN" \