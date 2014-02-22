#!/usr/bin/env bats

@test "openssl can communicate securely with cacert.org" {
  /usr/bin/openssl s_client -connect cacert.org:443 | grep -i 'verify return code' | grep -i ok
}
