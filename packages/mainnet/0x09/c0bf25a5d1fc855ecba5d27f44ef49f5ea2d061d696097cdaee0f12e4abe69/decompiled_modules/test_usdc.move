module 0x9c0bf25a5d1fc855ecba5d27f44ef49f5ea2d061d696097cdaee0f12e4abe69::test_usdc {
    struct TEST_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_USDC>(arg0, 6, b"tUSDC", b"Test USDC", b"Test stablecoin for Ahoi MVP", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_USDC>>(0x2::coin::mint<TEST_USDC>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_USDC>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_USDC>>(v1);
    }

    // decompiled from Move bytecode v7
}

