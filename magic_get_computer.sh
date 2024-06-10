#!/bin/bash

# Configurazione delle variabili
GLPI_INSTANCE_URL="https://magic.smeupics.cloud"
USER_TOKEN="CXRI0DbnD0N2tJozWpuRIqUuQX9kV2ZgsIChJdCv"
APP_TOKEN="NHSPoJRnr7mF0gkdlZWTDCGsdWSL9bw1SDTcwbLp"
#USERNAME="your-username"
#PASSWORD="your-password"

# Inizializzazione della sessione
echo "Inizializzazione della sessione..."
INIT_SESSION_RESPONSE=$(curl -X POST "$GLPI_INSTANCE_URL/apirest.php/initSession" \
-H "Content-Type: application/json" \
-H "Authorization: user_token $USER_TOKEN" \
-H "App-Token: $APP_TOKEN" \
#-d '{
#  "login": "'"$USERNAME"'",
#  "password": "'"$PASSWORD"'"
#}'
)

# Estrazione del token della sessione
SESSION_TOKEN=$(echo $INIT_SESSION_RESPONSE | jq -r '.session_token')

# Verifica se l'inizializzazione della sessione è riuscita
if [ "$SESSION_TOKEN" == "null" ]; then
  echo "Errore durante l'inizializzazione della sessione"
  exit 1
fi

# Verifica se l'inizializzazione della sessione è riuscita
if [ -z "$SESSION_TOKEN" ] || [ "$SESSION_TOKEN" == "null" ]; then
  echo "Errore durante l'inizializzazione della sessione: token non valido."
  exit 1
fi

echo "Sessione inizializzata con successo. Token di sessione: $SESSION_TOKEN"

# Esecuzione della query sull'endpoint Computer
echo "Esecuzione della query sull'endpoint Computer..."
COMPUTER_RESPONSE=$(curl -X GET "$GLPI_INSTANCE_URL/apirest.php/Computer" \
-H 'Content-Type: application/json' \
-H "Authorization: user_token $USER_TOKEN" \
-H "Session-Token: $SESSION_TOKEN" \
-H "App-Token: $APP_TOKEN")

echo "Risposta dalla query sull'endpoint Computer:"
echo $COMPUTER_RESPONSE | jq

# Terminazione della sessione
echo "Terminazione della sessione..."
curl -X POST "$GLPI_INSTANCE_URL/apirest.php/killSession" \
-H "Content-Type: application/json" \
-H "Authorization: user_token $USER_TOKEN" \
-H "Session-Token: $SESSION_TOKEN" \
-H "App-Token: $APP_TOKEN"

echo "Sessione terminata."
