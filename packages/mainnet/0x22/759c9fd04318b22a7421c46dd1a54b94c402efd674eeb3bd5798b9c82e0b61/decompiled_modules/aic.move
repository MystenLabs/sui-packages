module 0x22759c9fd04318b22a7421c46dd1a54b94c402efd674eeb3bd5798b9c82e0b61::aic {
    struct AIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIC>(arg0, 6, b"AIC", b"AI Coin", b"AI Coin is the token that bridges the cryptocurrency universe with the revolution of Artificial Intelligence. A decentralized project promising to transform the market with innovative applications, data mining, and blockchain solutions powered by AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aicoin_0e02a1dcab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIC>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIC>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

