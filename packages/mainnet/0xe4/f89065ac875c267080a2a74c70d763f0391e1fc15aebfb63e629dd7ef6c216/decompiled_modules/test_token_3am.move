module 0xe4f89065ac875c267080a2a74c70d763f0391e1fc15aebfb63e629dd7ef6c216::test_token_3am {
    struct TEST_TOKEN_3AM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_TOKEN_3AM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN_3AM>(arg0, 10, b"TEST_TOKEN_3AM", b"testtoken3am", b"testtoken3am description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_TOKEN_3AM>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_TOKEN_3AM>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_TOKEN_3AM>>(v1);
    }

    // decompiled from Move bytecode v6
}

