module 0x5beccc981b1c08b0932c856957bbf8a9f669e210db6712de628d9bdd5608d961::test_ayu_1 {
    struct TEST_AYU_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_AYU_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_AYU_1>(arg0, 6, b"TEST_AYU_1", b"TEST_AYU_1", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_AYU_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST_AYU_1>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

