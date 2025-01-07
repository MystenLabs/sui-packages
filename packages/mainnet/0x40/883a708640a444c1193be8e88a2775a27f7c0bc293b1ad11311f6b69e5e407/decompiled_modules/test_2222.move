module 0x40883a708640a444c1193be8e88a2775a27f7c0bc293b1ad11311f6b69e5e407::test_2222 {
    struct TEST_2222 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_2222, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_2222>(arg0, 6, b"TEST2222", b"Test2222", b"test222", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-internal-do-not-share.hop.ag/carrot_pile.svg")), arg1);
        0x2::transfer::public_transfer<0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::Connector<TEST_2222>>(0x931cc23b9c6fd3e6f8b5ef68955a2bf83ab36a7d8c995334afe3616f5fd586c7::connector::new<TEST_2222>(v0, v1, 0x2::tx_context::sender(arg1), arg1), @0xaf50f089101e7b4650b028d1567aaeb80b42867143cda135a06bf2f4e95815aa);
    }

    // decompiled from Move bytecode v6
}

