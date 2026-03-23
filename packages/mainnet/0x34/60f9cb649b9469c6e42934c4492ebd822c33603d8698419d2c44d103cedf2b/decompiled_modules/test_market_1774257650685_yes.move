module 0x3460f9cb649b9469c6e42934c4492ebd822c33603d8698419d2c44d103cedf2b::test_market_1774257650685_yes {
    struct TEST_MARKET_1774257650685_YES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_MARKET_1774257650685_YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_MARKET_1774257650685_YES>(arg0, 0, b"YES", b"YES", b"YES position", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_MARKET_1774257650685_YES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_MARKET_1774257650685_YES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

