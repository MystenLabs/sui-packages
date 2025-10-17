module 0x7fe306cf729750f2065a70a0b7c98578616f2dc37b2bd5a0f477aae5b51f5f69::test_coin {
    struct TEST_COIN has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_COIN>>(0x2::coin::mint<TEST_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TEST_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_COIN>(arg0, 6, b"tCOIN1", b"tCOIN1", b"tCOIN2", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

