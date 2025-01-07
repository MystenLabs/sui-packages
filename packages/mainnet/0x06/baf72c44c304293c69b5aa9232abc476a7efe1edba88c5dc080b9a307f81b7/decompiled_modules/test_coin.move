module 0x6baf72c44c304293c69b5aa9232abc476a7efe1edba88c5dc080b9a307f81b7::test_coin {
    struct TEST_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST_COIN>, arg1: 0x2::coin::Coin<TEST_COIN>) {
        0x2::coin::burn<TEST_COIN>(arg0, arg1);
    }

    fun init(arg0: TEST_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_COIN>(arg0, 9, b"TEST", b"Test Coin", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

