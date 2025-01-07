module 0xf6fc05135ff6c9fbe5009be926fc6fdca2aa5bdb1d3523dff36857a9dab48559::test_token_thr {
    struct TEST_TOKEN_THR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_TOKEN_THR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN_THR>(arg0, 10, b"TEST_TOKEN_THR", b"test-token-321", b"test-token-321", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TEST_TOKEN_THR>(&mut v2, 90000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_TOKEN_THR>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_TOKEN_THR>>(v1);
    }

    // decompiled from Move bytecode v6
}

