module 0x19987a01afd79d8afb80a7ef851ef246784e30e3c0179fafaa7a8c45c04d05f5::test_five {
    struct TEST_FIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_FIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_FIVE>(arg0, 9, b"test_five", b"test_five", b"test dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_FIVE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_FIVE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_FIVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

