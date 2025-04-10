module 0xc85fd68ee4d49743d3f15da159a5c62714290f39c41eab769a5f6b9b22a1549d::test_btc {
    struct TEST_BTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_BTC>(arg0, 8, b"BTC", b"Test Bitcoin", b"Test Bitcoin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_BTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_BTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

