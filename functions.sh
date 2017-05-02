#!/bin/bash
# Jarvis-google-map-traffic base functions

jv_pg_gm_check_traffic() {
    
    if [[ -n "$jv_pg_gm_api_key" ]]; then
        local json=$(curl -s -G "https://maps.googleapis.com/maps/api/directions/json" --data "language=fr" --data-urlencode "origin=$jv_pg_gm_city_from" --data-urlencode "destination=$jv_pg_gm_city_to" --data "traffic_model=best_guess" --data "departure_time=now" --data-urlencode "key=$jv_pg_gm_api_key")
        status=$(echo "$json" | jq -r '.status')
    else
        echo $(jv_pg_gm_invalid_key_locale)
        exit
    fi
    
    case "$status" in
        REQUEST_DENIED)
            echo $(jv_pg_gm_invalid_key_locale)
            ;;
        ZERO_RESULTS)
            echo $(jv_pg_gm_zero_results_locale)
            ;;
        OVER_QUERY_LIMIT)
            echo $(jv_pg_gm_over_query_limit_locale)
            ;;
        OK)
            local duration=$(echo "$json" | jq -r '.routes[0].legs[0].duration.value')
            local duration_in_traffic=$(echo "$json" | jq -r '.routes[0].legs[0].duration_in_traffic.value')
            local duration_in_traffic_text=$(echo "$json" | jq -r '.routes[0].legs[0].duration_in_traffic.text')
            local summary=$(echo "$json" | jq -r '.routes[0].summary')
            local difference=$((($duration_in_traffic-$duration)/60))
            if [ "$difference" -lt "0" ]; then  # Avoid negative values
                difference=0
            fi
            echo "$(jv_pg_gm_check_traffic_locale "$FROM" "$TO" "$summary" "$duration_in_traffic_text" "$difference")"
            ;;
        *)
          jv_warning "google-map-traffic - Request error : $status"
    esac
}
