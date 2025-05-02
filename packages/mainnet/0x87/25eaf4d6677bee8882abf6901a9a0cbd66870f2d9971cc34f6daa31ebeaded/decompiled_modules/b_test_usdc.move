module 0x8725eaf4d6677bee8882abf6901a9a0cbd66870f2d9971cc34f6daa31ebeaded::b_test_usdc {
    struct B_TEST_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TEST_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TEST_USDC>(arg0, 9, b"btUSDC", b"bToken tUSDC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TEST_USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TEST_USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

