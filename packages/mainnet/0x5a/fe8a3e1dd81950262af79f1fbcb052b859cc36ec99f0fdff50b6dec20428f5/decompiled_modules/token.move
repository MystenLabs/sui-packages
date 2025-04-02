module 0x5afe8a3e1dd81950262af79f1fbcb052b859cc36ec99f0fdff50b6dec20428f5::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<TOKEN>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<TOKEN>(arg0, b"TOKEN", b"Testtt", b"New test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXf6i8Lhsj6M3wMpSCf4zWxfZhuGC6QhWj2RWDCNaR3UW")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0097687c3266dedfffcc7c5df5fa6bf12dec34b4a9d017668fa714530fa22123fcfc40b6faf95025f70137e088e89c54229190f46f617e4f5983aa05bec64d4b0a7b08d9209dea8e2521b5e3f461f27ccd9b2ac43433f9f61559a0ee890e4e72851743599951"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

