module 0x80b20af8e84dc1146d048286a03adaa7af012348105300c459ef8db7bf50812a::test_ayu_2 {
    struct TEST_AYU_2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_AYU_2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_AYU_2>(arg0, 6, b"TEST_AYU_2", b"TEST_AYU_2", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_AYU_2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST_AYU_2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

