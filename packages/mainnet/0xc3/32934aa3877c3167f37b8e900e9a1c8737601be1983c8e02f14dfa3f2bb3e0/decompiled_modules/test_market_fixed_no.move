module 0xc332934aa3877c3167f37b8e900e9a1c8737601be1983c8e02f14dfa3f2bb3e0::test_market_fixed_no {
    struct TEST_MARKET_FIXED_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_MARKET_FIXED_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_MARKET_FIXED_NO>(arg0, 0, b"NO", b"NO", b"NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_MARKET_FIXED_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_MARKET_FIXED_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

