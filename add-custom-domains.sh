#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${EXTRA_ALLOWED_DOMAINS:-}" ]]; then
    exit 0
fi

echo "Adding custom allowed domains..."

# Normalize: replace commas with spaces
domains=$(echo "${EXTRA_ALLOWED_DOMAINS}" | tr ',' ' ')

for domain in $domains; do
    [[ -z "$domain" ]] && continue
    ips=$(dig +short A "$domain" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$')
    if [[ -z "$ips" ]]; then
        echo "  WARNING: could not resolve $domain" >&2
        continue
    fi
    for ip in $ips; do
        if ipset test allowed-domains "$ip" 2>/dev/null; then
            echo "  $domain -> $ip (already present)"
        else
            ipset add allowed-domains "$ip"
            echo "  $domain -> $ip (added)"
        fi
    done
done
