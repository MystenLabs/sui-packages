module 0x24daa99a0eaaf344dd04754489eb6366d04b8630d4d96c976a0b2156188713b8::test_coin {
    struct TEST_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_COIN>(arg0, 9, b"TEST", b"test", b"test", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

