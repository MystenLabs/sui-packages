module 0xc437c8c419f507f3d6ceec174d676c50070ec02d51d52ef772a0388fd13c7db9::smoke {
    struct SMOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOKE>(arg0, 9, b"SMOKE", b"Arena Smoke", b"live smoke test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SMOKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

