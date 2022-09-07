# Defined in - @ line 1
function bltotp --description 'get bukalapak totp' --argument name
    cd $HOME/Devs/vpns

    switch $name
        case bl
            export (cat .env |xargs -L 1)
            set -l secret $BLVPN_SECRET
            set -l totp (oathtool -b --totp $secret)
            echo $totp | pbcopy
        case b2
            export (cat .env |xargs -L 1)
            set -l secret $B2VPN_SECRET
            set -l totp (oathtool -b --totp $secret)
            echo $totp | pbcopy
    end

end
