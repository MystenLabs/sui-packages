module 0x7a892eda23d069cbf5f9c92e8fcb478dcc7f303738f5d7523a53102d8f5fa3e8::bobr {
    struct BOBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBR>(arg0, 6, b"Bobr", x"42c3b3626572204b55525741", x"42c3b3626572206b757277612069732074686520666972737420506f6c697368206d656d6520636f696e206261736564206f6e2074686520706f70756c61722022426f6272204b75727761204a612050696572646f6c6522696e7465726e6574206d656d652e0a436865636b20696e3a2068747470733a2f2f7777772e796f75747562652e636f6d2f73686f7274732f5767593551356439534e51", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731620452196.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOBR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

