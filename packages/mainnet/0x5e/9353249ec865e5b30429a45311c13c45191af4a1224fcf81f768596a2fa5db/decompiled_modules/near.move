module 0x5e9353249ec865e5b30429a45311c13c45191af4a1224fcf81f768596a2fa5db::near {
    struct NEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEAR>(arg0, 8, b"NEAR", b"Wrapped NEAR", b"ZO Finance Virtual Coin for NEAR", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEAR>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NEAR>>(v0);
    }

    // decompiled from Move bytecode v7
}

