# Defined in - @ line 1
function b2vpn --description 'connect to Buka 2.0 vpn' --argument name
    cd $HOME/Devs/vpns
    export (cat .env |xargs -L 1)

    set -l secret $B2VPN_SECRET
    set -l username $BLVPN_USERNAME
    set -l totp (oathtool -b --totp $secret)
    set -l password "$BLVPN_PASSWORD$totp"
    set -l configFile "./b2.ovpn"

    switch $name
        case core-dev
            kubectl config use-context aks-core-dev-kubernetes-main
        case o2o-dev
            kubectl config use-context aks-o2o-dev-kubernetes-main
        case core-stg
            kubectl config use-context aks-core-stg-kubernetes-main
        case o2o-stg
            kubectl config use-context aks-o2o-stg-kubernetes-main
        case core-prod
            kubectl config use-context aks-core-prod-kubernetes-main
        case o2o-prod
            kubectl config use-context aks-o2o-prod-kubernetes-main
        case '*'
            echo 'not found'
    end

    echo >auth-user-pass.txt "$username
$password"

    sudo openvpn --config $configFile --auth-user-pass ./auth-user-pass.txt
    rm ./auth-user-pass.txt
end
