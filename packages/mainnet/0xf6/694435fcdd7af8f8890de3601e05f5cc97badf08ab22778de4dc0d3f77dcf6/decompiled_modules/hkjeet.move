module 0xf6694435fcdd7af8f8890de3601e05f5cc97badf08ab22778de4dc0d3f77dcf6::hkjeet {
    struct HKJEET has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKJEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HKJEET>(arg0, 6, b"HKJEET", b"Jeet of Hong Kong", b"Keith the jeet of Hong Kong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JB9VKN3YDJVCQTM84X7F2M2Q/01JB9WQDH49J35P2RMBVZHY08B")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKJEET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HKJEET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

