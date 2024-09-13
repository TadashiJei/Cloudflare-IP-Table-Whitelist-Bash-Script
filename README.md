# Cloudflare IP Whitelisting Script for `iptables`

This script automatically whitelists Cloudflare's IP addresses in your server's `iptables` firewall rules. It includes both IPv4 and IPv6 addresses, ensuring that only traffic from Cloudflare can reach your web server.

## How to Use

1. **Clone the Repository:**
   ```bash
   https://github.com/TadashiJei/Cloudflare-IP-Table-Whitelist-Bash-Script.git
   cd cloudflare-iptables-whitelist
   ```

2. **Make the Script Executable:**
   ```bash
   chmod +x whitelist_cloudflare.sh
   ```

3. **Run the Script:**
   ```bash
   ./whitelist_cloudflare.sh
   ```

   This script will add all Cloudflare IP ranges to your `iptables` rules and save the configuration so that it persists across reboots.

## Troubleshooting

### Common Issue: Directory Not Found

If you encounter the following error:

```
./whitelist_cloudflare.sh: line 50: /etc/iptables/rules.v4: No such file or directory
./whitelist_cloudflare.sh: line 51: /etc/iptables/rules.v4: No such file or directory
```

This means the directory where `iptables` rules are saved does not exist. To fix this, create the directory using the following command:

```bash
sudo mkdir -p /etc/iptables
```

Then, run the script again:

```bash
./whitelist_cloudflare.sh
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
