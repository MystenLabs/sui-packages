module 0x76142775c77979fde15f78b76e21d614ff4823cf3a869cc777da49433addefda::bbl {
    struct BBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<BBL>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<BBL>(arg0, b"BBL", b"Bable", b"Bable BBL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQDtS7VrpQyWAzYH254vJpkeebmeZavFbjCHEWcGb9EJe")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001709a86116ffe9206baece6dd0eb9014eae58cd58ed434d9029281444cb9b81143616df8806cc17e6338179544b92d80b9045825659a0a676cf8b9414261b10df5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631743164291"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

