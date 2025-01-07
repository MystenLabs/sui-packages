module 0x3a7599c3e1c3b42400fc73a0e983b25a435ca57580522a3681e46dc94654f593::test_111 {
    struct TEST_111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_111, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_111>(arg0, 6, b"TEST111", b"Test1111", b"tes1111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-internal-do-not-share.hop.ag/carrot_pile.svg")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<TEST_111>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<TEST_111>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

