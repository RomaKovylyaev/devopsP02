#!/usr/bin/env bash
set -euo pipefail

CITY="${1:-Perm}"
OUT_FILE="/var/www/html/index.nginx-debian.html"
JSON_DATA=$(curl -s --fail "https://wttr.in/${CITY}?format=j2")

TEMP=$(echo "$JSON_DATA" | jq -r '.current_condition[0].temp_C')
HUMIDITY=$(echo "$JSON_DATA" | jq -r '.current_condition[0].humidity')
NOW=$(date)

echo "City: ${CITY} | Temp: ${TEMP} C | Humidity: ${HUMIDITY}% | Time: ${NOW}"

cat << HTML > "$OUT_FILE"
<!DOCTYPE html>
<html lang="ru">
<head>
  <meta charset="UTF-8">
  <title>Weather in ${CITY}</title>
</head>
<body>
  <h1>Погода в городе: ${CITY}</h1>
  <p>Температура: ${TEMP} °C</p>
  <p>Влажность: ${HUMIDITY}%</p>
  <p>Обновлено: ${NOW}</p>
</body>
</html>
HTML
