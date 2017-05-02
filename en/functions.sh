#!/bin/bash
# Jarvis-google-map-traffic English functions

jv_pg_gm_check_traffic_locale() {
    echo "The best estimated route for $jv_pg_gm_city_from-$jv_pg_gm_city_to via $summary is $duration_in_traffic_text including $difference minutes late"
}

jv_pg_gm_invalid_key_locale() {
    echo "Invalid Google API key"
}

jv_pg_gm_zero_results_locale() {
    echo "Can not indentify cities, please specify country or state"
}

jv_pg_gm_over_query_limit_locale() {
    echo "Access requests over limit for your API key."
}