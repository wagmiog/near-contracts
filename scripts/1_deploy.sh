#./build.sh
##!/usr/bin/env bash
#
#[ -z "$CONTRACT" ] && echo "Missing \$CONTRACT environment variable"
#[ -z "$OWNER" ] && echo "Missing \$OWNER environment variable"
#
#echo "deleting $CONTRACT and setting $OWNER as beneficiary"
#echo
#near delete $CONTRACT $OWNER
near delete "$(<./neardev/dev-account)" "$(<./neardev/owner-account)"

echo --------------------------------------------
echo
echo "cleaning up the /neardev folder"
echo
rm -rf ./neardev

# exit on first error after this point to avoid redeploying with successful build
set -e

near dev-deploy --wasmFile res/fungible_token.wasm --helperUrl https://near-contract-helper.onrender.com
source neardev/dev-account.env
echo "deploying near png token"
near call $CONTRACT_NAME new '{"owner_id": "'$CONTRACT_NAME'", "total_supply": "1000000000000000", "metadata": { "spec": "ft-1.0.0", "name": "Near Pangolin Token", "symbol": "nPNG", "decimals": 18 }}' --accountId $CONTRACT_NAME