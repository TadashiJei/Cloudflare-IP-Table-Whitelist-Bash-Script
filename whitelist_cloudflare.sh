#!/bin/bash

# ASCII Art for welcome message
welcome_message() {
    cat << "EOF"
▄▄▄█████▓ ▄▄▄      ▓█████▄  ▄▄▄        ██████  ██░ ██  ██▓    ▄▄▄██▀▀▀▓█████  ██▓
▓  ██▒ ▓▒▒████▄    ▒██▀ ██▌▒████▄    ▒██    ▒ ▓██░ ██▒▓██▒      ▒██   ▓█   ▀ ▓██▒
▒ ▓██░ ▒░▒██  ▀█▄  ░██   █▌▒██  ▀█▄  ░ ▓██▄   ▒██▀▀██░▒██▒      ░██   ▒███   ▒██▒
░ ▓██▓ ░ ░██▄▄▄▄██ ░▓█▄   ▌░██▄▄▄▄██   ▒   ██▒░▓█ ░██ ░██░   ▓██▄██▓  ▒▓█  ▄ ░██░
  ▒██▒ ░  ▓█   ▓██▒░▒████▓  ▓█   ▓██▒▒██████▒▒░▓█▒░██▓░██░    ▓███▒   ░▒████▒░██░
  ▒ ░░    ▒▒   ▓▒█░ ▒▒▓  ▒  ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒░▓      ▒▓▒▒░   ░░ ▒░ ░░▓  
    ░      ▒   ▒▒ ░ ░ ▒  ▒   ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░ ▒ ░    ▒ ░▒░    ░ ░  ░ ▒ ░
  ░        ░   ▒    ░ ░  ░   ░   ▒   ░  ░  ░   ░  ░░ ░ ▒ ░    ░ ░ ░      ░    ▒ ░
               ░  ░   ░          ░  ░      ░   ░  ░  ░ ░      ░   ░      ░  ░ ░  
                    ░                                                            
EOF
}

# Cloudflare IPv4 addresses
ipv4_addresses=(
    "173.245.48.0/20"
    "103.21.244.0/22"
    "103.22.200.0/22"
    "103.31.4.0/22"
    "141.101.64.0/18"
    "108.162.192.0/18"
    "190.93.240.0/20"
    "188.114.96.0/20"
    "197.234.240.0/22"
    "198.41.128.0/17"
    "162.158.0.0/15"
    "104.16.0.0/12"
    "172.64.0.0/13"
    "131.0.72.0/22"
)

# Cloudflare IPv6 addresses
ipv6_addresses=(
    "2400:cb00::/32"
    "2606:4700::/32"
    "2803:f800::/32"
    "2405:b500::/32"
    "2405:8100::/32"
    "2a06:98c0::/29"
    "2c0f:f248::/32"
)

# Function to add IPv4 addresses to iptables
whitelist_ipv4() {
    for ip in "${ipv4_addresses[@]}"; do
        sudo iptables -I INPUT -p tcp -s "$ip" -j ACCEPT
        echo "Whitelisted IPv4: $ip"
    done
}

# Function to add IPv6 addresses to ip6tables
whitelist_ipv6() {
    for ip in "${ipv6_addresses[@]}"; do
        sudo ip6tables -I INPUT -p tcp -s "$ip" -j ACCEPT
        echo "Whitelisted IPv6: $ip"
    done
}

# Function to save iptables rules
save_iptables() {
    if [ ! -d /etc/iptables ]; then
        echo "Creating /etc/iptables directory..."
        sudo mkdir -p /etc/iptables
    fi
    sudo iptables-save > /etc/iptables/rules.v4
    sudo ip6tables-save > /etc/iptables/rules.v6
    echo "iptables rules saved."
}

# Main function to run the script
main() {
    welcome_message
    echo "Choose an option:"
    echo "1. Whitelist Cloudflare IPs"
    echo "2. Exit"
    read -p "Enter your choice [1/2]: " choice

    case $choice in
        1)
            echo "Whitelisting Cloudflare IPs..."
            whitelist_ipv4
            whitelist_ipv6
            save_iptables
            echo "All Cloudflare IPs have been whitelisted."
            ;;
        2)
            echo "Exiting script."
            ;;
        *)
            echo "Invalid option. Exiting."
            ;;
    esac
}

# Run the main function
main
