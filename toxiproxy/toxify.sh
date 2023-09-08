#!/bin/bash

SERVICE_NAME=mockapi_dev

TIMEOUT_ENABLED=0
LATENCY_ENABLED=0
OUTAGE_ENABLED=0

# Toxic functions
enable_timeout() {
    if (( TIMEOUT_ENABLED == 0 )); then
        echo "enabling timeouts..."
        curl -s -X POST http://toxiproxy:8474/proxies/$SERVICE_NAME/toxics -d'{
            "type": "timeout",
            "name": "timeouts",
            "attributes": {"timeout": 7000}
        }' > /dev/null
        TIMEOUT_ENABLED=1
    fi
}

disable_timeout() {
    if (( TIMEOUT_ENABLED == 1 )); then
        echo "disabling timeouts..."
        curl -s -X DELETE http://toxiproxy:8474/proxies/$SERVICE_NAME/toxics/timeouts > /dev/null
        TIMEOUT_ENABLED=0
    fi
}

enable_latency() {
    if (( LATENCY_ENABLED == 0 )); then
        echo "enabling latency..."
        curl -s -X POST http://toxiproxy:8474/proxies/$SERVICE_NAME/toxics -d'{
            "type": "latency",
            "name": "lag",
            "attributes": {"latency": 3000, "jitter": 2000}
        }' > /dev/null
        LATENCY_ENABLED=1
    fi
}

disable_latency() {
    if (( LATENCY_ENABLED == 1 )); then
        echo "disabling latency..."
        curl -s -X DELETE http://toxiproxy:8474/proxies/$SERVICE_NAME/toxics/lag > /dev/null
        LATENCY_ENABLED=0
    fi
}

enable_outage() {
    if (( OUTAGE_ENABLED == 0 )); then
        echo "enabling outage..."
        curl -s -X POST http://toxiproxy:8474/proxies/$SERVICE_NAME -d'{
            "enabled": false
        }' > /dev/null
        OUTAGE_ENABLED=1
    fi
}

disable_outage() {
    if (( OUTAGE_ENABLED == 1 )); then
        echo "disabling outage..."
        curl -s -X POST http://toxiproxy:8474/proxies/$SERVICE_NAME -d'{
            "enabled": true
        }' > /dev/null
        OUTAGE_ENABLED=0
    fi
}


# Sleep to allow toxiproxy to start listening
sleep 5

# Add upstream
curl -s -X POST -d "{\"name\": \"$SERVICE_NAME\", \"listen\": \"toxiproxy:18080\", \"upstream\": \"mockoon:3000\"}" http://toxiproxy:8474/proxies > /dev/null

# infinite loop
while true
do
    # Disable all toxics from previous iteration
    disable_timeout
    disable_latency
    disable_outage

    # Randomly choose a new toxic or as per your request, do nothing (50% chance)
    case $(( RANDOM % 6 )) in
        0)
            enable_timeout
            ;;
        1)
            enable_latency
            ;;
        2)
            enable_outage
            ;;
        3) # Do nothing
            ;;
        4) # Do nothing
            ;;
        5) # Do nothing
            ;;
    esac

    # Sleep for 30 seconds before the next iteration.
    sleep 30
done