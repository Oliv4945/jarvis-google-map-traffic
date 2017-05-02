#!/bin/bash
# Jarvis-google-map-traffic base functions

jv_pg_gm_check_traffic() {
    local json=$(curl -s -G "https://maps.googleapis.com/maps/api/directions/json" --data "language=fr" --data-urlencode "origin=$FROM" --data-urlencode "destination=$TO" --data "traffic_model=best_guess" --data "departure_time=now" --data-urlencode "key=$APIKEY")
    local duration=$(echo "$json" | jq -r '.routes[0].legs[0].duration.value')
    local duration_in_traffic=$(echo "$json" | jq -r '.routes[0].legs[0].duration_in_traffic.value')
    local duration_in_traffic_text=$(echo "$json" | jq -r '.routes[0].legs[0].duration_in_traffic.text')
    local summary=$(echo "$json" | jq -r '.routes[0].summary')
    local difference=$((($duration_in_traffic-$duration)/60))
    echo "$(jv_pg_gm_check_traffic_locale "$FROM" "$TO" "$summary" "$duration_in_traffic_text" "$difference")"
}
