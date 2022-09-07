# Defined in - @ line 1
function blvpn --description 'connect to Bukalapak vpn' --argument name
    cd $HOME/Devs/vpns
    export (cat .env |xargs -L 1)

    set -l secret $BLVPN_SECRET
    set -l username $BLVPN_USERNAME
    set -l totp (oathtool -b --totp $secret)
    set -l password "$BLVPN_PASSWORD$totp"


    switch $name
        case prod
            kubectl config use-context gke_kubernetes-prod-94cb_asia-southeast1_k8s-production-2
            set -l configFile "./bl-production.ovpn"
            sudo openvpn --config $configFile --auth-user-pass ./auth-user-pass.txt
        case preprod
            kubectl config use-context gke_kubernetes-preprod-0d59_asia-southeast1_k8s-preproduction-2
            set -l configFile "./bl-preproduction.ovpn"
            sudo openvpn --config $configFile --auth-user-pass ./auth-user-pass.txt
        case prod-mom
            kubectl config use-context gke_kubernetes-prod-94cb_asia-southeast1_k8s-production-3
            set -l configFile "./bl-production.ovpn"
            sudo openvpn --config $configFile --auth-user-pass ./auth-user-pass.txt
        case preprod-mom
            kubectl config use-context gke_kubernetes-preprod-0d59_asia-southeast1_k8s-preproduction-3
            set -l configFile "./bl-preproduction.ovpn"
            sudo openvpn --config $configFile --auth-user-pass ./auth-user-pass.txt
        case '*'
            echo 'not found'
    end

    echo >auth-user-pass.txt "$username
$password"

    sudo openvpn --config $configFile --auth-user-pass ./auth-user-pass.txt

    rm ./auth-user-pass.txt
end
