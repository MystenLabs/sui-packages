module 0x6b755948cc744bf1ceafdd13ab82a92806b1704f5cef96d72792be7a73b8db81::test_token_lp {
    struct TEST_TOKEN_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_TOKEN_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN_LP>(arg0, 10, b"TEST_TOKEN_LP", b"lpcoin", b"lp coin for pool", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_TOKEN_LP>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_TOKEN_LP>>(v2, @0x9a32c41920a66f4919a3d011dac7d45fb79d2629d4c5dce937d550339bbad8e2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_TOKEN_LP>>(v1);
    }

    // decompiled from Move bytecode v6
}

