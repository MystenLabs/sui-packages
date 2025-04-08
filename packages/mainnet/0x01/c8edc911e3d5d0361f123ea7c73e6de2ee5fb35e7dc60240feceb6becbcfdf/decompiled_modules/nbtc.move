module 0x1c8edc911e3d5d0361f123ea7c73e6de2ee5fb35e7dc60240feceb6becbcfdf::nbtc {
    struct NBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NBTC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<NBTC>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<NBTC>(arg0, b"NBTC", b"Not BTC", b"this is not BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbTiFbgzSnzuKHzLEdeGMNKqRM5XxJZ6ahzPZZfJEjxML")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b256fd5a0bc75065c8c93db4f9577ea6cf34f102076b6b2e7c4bfc405b13ca20f4d26b5d4b1597bb2fd0f11fa8a3ce48267a5c71920d07f0aa585c3565399706f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744102348"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

