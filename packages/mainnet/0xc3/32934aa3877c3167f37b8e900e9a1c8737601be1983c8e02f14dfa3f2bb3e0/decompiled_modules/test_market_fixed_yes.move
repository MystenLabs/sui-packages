module 0xc332934aa3877c3167f37b8e900e9a1c8737601be1983c8e02f14dfa3f2bb3e0::test_market_fixed_yes {
    struct TEST_MARKET_FIXED_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_MARKET_FIXED_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_MARKET_FIXED_YES>(arg0, 0, b"YES", b"YES", b"YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_MARKET_FIXED_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_MARKET_FIXED_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

