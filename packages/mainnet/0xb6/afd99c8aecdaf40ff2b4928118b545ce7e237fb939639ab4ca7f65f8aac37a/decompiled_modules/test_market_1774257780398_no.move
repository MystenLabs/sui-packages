module 0xb6afd99c8aecdaf40ff2b4928118b545ce7e237fb939639ab4ca7f65f8aac37a::test_market_1774257780398_no {
    struct TEST_MARKET_1774257780398_NO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_MARKET_1774257780398_NO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_MARKET_1774257780398_NO>(arg0, 0, b"NO", b"NO", b"NO position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_MARKET_1774257780398_NO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_MARKET_1774257780398_NO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

