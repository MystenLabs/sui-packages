module 0x4fba497702e652dcb0b786a6ac1e1beb231d770f0359ed7d129bf800cc5d607e::test_token_thr {
    struct TEST_TOKEN_THR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_TOKEN_THR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN_THR>(arg0, 10, b"TEST_TOKEN_THR", b"test token 321", b"test-token-321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_TOKEN_THR>(&mut v2, 90000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_TOKEN_THR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_TOKEN_THR>>(v1);
    }

    // decompiled from Move bytecode v6
}

