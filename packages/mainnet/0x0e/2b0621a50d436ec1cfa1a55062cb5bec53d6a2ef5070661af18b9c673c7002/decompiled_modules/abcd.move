module 0xe2b0621a50d436ec1cfa1a55062cb5bec53d6a2ef5070661af18b9c673c7002::abcd {
    struct ABCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABCD>(arg0, 6, b"abcd", b"test22", b"dddddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JB6ABKQK6SYTGM8P0P30C6J9/01JB6CYBPMXJX5BS695SRHWTTN")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ABCD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

