module 0xdb6828b52677e85296e36ebffb4067f9f55dda6d22a22b6b8856748e44550393::cybai {
    struct CYBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBAI>(arg0, 6, b"CYBAI", b"CyberAI", b"Cybsupporting erAI (CYBAI) is an AI-powered utility token on the Sui blockchain. This Sui deployment has a fixed supply of 10,000,000 CYBAI and expands the CyberAI ecosystem across multiple blockchains, AI trading bots, DeFi, staking, and future cross-chain interoperability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo1_2464f66abf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

