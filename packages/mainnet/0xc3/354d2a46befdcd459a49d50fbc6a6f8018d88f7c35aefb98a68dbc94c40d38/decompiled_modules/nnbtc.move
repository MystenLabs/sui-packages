module 0xc3354d2a46befdcd459a49d50fbc6a6f8018d88f7c35aefb98a68dbc94c40d38::nnbtc {
    struct NNBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NNBTC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<NNBTC>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<NNBTC>(arg0, b"NNBTC", b"Not NBTC", b"this is not NBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbTiFbgzSnzuKHzLEdeGMNKqRM5XxJZ6ahzPZZfJEjxML")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b21b3ecc0cb6eef125db12a1a5a8392d69e1374c8ef04f88a3779680a92c43d0c9d9b8a742b868e51b0a9fddfcea00a6aeb2e735c9543282a7763c5d3097e606f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744106564"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

