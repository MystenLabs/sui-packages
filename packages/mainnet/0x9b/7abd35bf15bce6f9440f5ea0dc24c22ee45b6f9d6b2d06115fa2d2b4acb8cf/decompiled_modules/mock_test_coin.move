module 0x9b7abd35bf15bce6f9440f5ea0dc24c22ee45b6f9d6b2d06115fa2d2b4acb8cf::mock_test_coin {
    struct MOCK_TEST_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOCK_TEST_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCK_TEST_COIN>>(0x2::coin::mint<MOCK_TEST_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOCK_TEST_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCK_TEST_COIN>(arg0, 9, b"TEST", b"TEST", b"Mock TEST Token for Gas Testing", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCK_TEST_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCK_TEST_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun register_metadata(arg0: &0x2::coin::CoinMetadata<MOCK_TEST_COIN>) {
    }

    // decompiled from Move bytecode v6
}

