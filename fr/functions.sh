#!/bin/bash
# Jarvis-google-map-traffic French functions

jv_pg_gm_check_traffic_locale() {
    echo "Le meilleur trajet $jv_pg_gm_city_from-$jv_pg_gm_city_to via $summary est estimé à $duration_in_traffic_text dont $difference minutes de retard"
}

jv_pg_gm_invalid_key_locale() {
    echo "Clef Google API invalide"
}

jv_pg_gm_zero_results_locale() {
    echo "Impossible d'indentifier les villes, essayez de préciser le pays ou le département"
}

jv_pg_gm_over_query_limit_locale() {
    echo "Limite d'accès associée à la clef API dépassée"
}