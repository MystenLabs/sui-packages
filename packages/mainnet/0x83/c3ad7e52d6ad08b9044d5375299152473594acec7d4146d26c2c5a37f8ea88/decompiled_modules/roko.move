module 0x83c3ad7e52d6ad08b9044d5375299152473594acec7d4146d26c2c5a37f8ea88::roko {
    struct ROKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ROKO>(arg0, 6, b"ROKO", b"ROKO by SuiAI", b"advanced AI-powered security framework designed to protect decentralized finance (DeFi) ecosystems. It offers real-time threat detection, adaptive responses, and proactive vulnerability management. With intelligent, autonomous defense capabilities, IRIS ensures a secure and resilient environment, empowering DeFi platforms to innovate with confidence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ROKO_a18849584f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROKO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROKO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

