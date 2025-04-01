module 0x86518340cc15853c76bcb63996c6fb36cd566755a870f46bccd3e95f6a0a4993::test_sui {
    struct TEST_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_SUI>(arg0, 9, b"testSUI", b"Test Staked SUI", b"test LST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Test-Logo.svg/2560px-Test-Logo.svg.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

