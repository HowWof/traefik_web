#!/bin/bash

# Fill .env data
if [ ! -f .env ]; then
    echo "##### SCRIPT GENERATED #####" > .env
else
    echo "" >> .env
    echo "##### SCRIPT GENERATED #####" >> .env
fi

add_env() {
    local variable_name="$1"
    local user_prompt="$2"

    read -p "$user_prompt" value

    if [ -z "$value" ]; then
        echo "Missing value"
        exit 1
    fi

    if grep -q "^$variable_name=" .env; then
        echo "Variable $variable_name already exist"
    else
        echo "$variable_name=$value" >> .env
        echo "Variable $variable_name added"
    fi
}

add_env "CLOUDFLARE_EMAIL" "Enter your Cloudflare email address: "
add_env "CLOUDFLARE_API_KEY" "Enter Cloudflare API key: "
add_env "DOMAINNAME_CLOUD_SERVER" "Enter the domain name: "
add_env "TZ" "Enter the timezone: "

# Create acme.json
touch appdata/traefik/acme/acme.json
chmod 600 appdata/traefik/acme/acme.json
