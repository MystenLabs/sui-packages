module 0xf53e6b4de5712b642fea2bd6a2a90d1a5ba7ab6fb75d5d6ff6e923345252633a::test_coin {
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

