module 0x9ec72b561e66440ced83025b1fad3b3293eadb104a31491e56bcd74446ba3d9e::test_ayu_3 {
    struct TEST_AYU_3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_AYU_3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_AYU_3>(arg0, 6, b"TEST_AYU_3", b"TEST_AYU_3", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_AYU_3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST_AYU_3>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

