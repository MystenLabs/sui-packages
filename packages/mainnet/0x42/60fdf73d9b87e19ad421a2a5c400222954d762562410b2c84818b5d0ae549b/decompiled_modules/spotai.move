module 0x4260fdf73d9b87e19ad421a2a5c400222954d762562410b2c84818b5d0ae549b::spotai {
    struct SPOTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOTAI>(arg0, 6, b"SPOTAI", b"Spot AI", b"Introducing SPOT AI: Your SUI Network Trading Companion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735570740463.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPOTAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOTAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

