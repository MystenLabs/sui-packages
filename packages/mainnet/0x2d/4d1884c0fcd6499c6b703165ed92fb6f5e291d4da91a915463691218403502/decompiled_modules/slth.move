module 0x2d4d1884c0fcd6499c6b703165ed92fb6f5e291d4da91a915463691218403502::slth {
    struct SLTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLTH>(arg0, 6, b"SLTH", b"Slithereum", b"In the year of the Snake, wisdom leads the way. Join Slithereum and transform your crypto journey with community-powered wealth and ancient insight. It's time to slither into success.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735402429131.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLTH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLTH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

