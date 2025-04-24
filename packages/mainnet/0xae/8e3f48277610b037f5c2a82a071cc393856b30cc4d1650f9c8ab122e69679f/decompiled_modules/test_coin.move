module 0xae8e3f48277610b037f5c2a82a071cc393856b30cc4d1650f9c8ab122e69679f::test_coin {
    struct TEST_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_COIN>(arg0, 6, b"TEST", b"test", b"Fixed-supply coin on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_COIN>>(0x2::coin::mint<TEST_COIN>(&mut v2, 5000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_COIN>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TEST_COIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

