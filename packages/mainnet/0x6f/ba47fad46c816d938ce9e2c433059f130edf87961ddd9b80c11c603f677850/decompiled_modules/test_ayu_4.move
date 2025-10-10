module 0x6fba47fad46c816d938ce9e2c433059f130edf87961ddd9b80c11c603f677850::test_ayu_4 {
    struct TEST_AYU_4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_AYU_4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_AYU_4>(arg0, 6, b"TEST_AYU_4", b"TEST_AYU_4", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_AYU_4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST_AYU_4>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

