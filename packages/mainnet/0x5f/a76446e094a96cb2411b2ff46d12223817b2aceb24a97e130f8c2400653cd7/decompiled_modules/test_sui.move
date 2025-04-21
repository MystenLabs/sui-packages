module 0x5fa76446e094a96cb2411b2ff46d12223817b2aceb24a97e130f8c2400653cd7::test_sui {
    struct TEST_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_SUI>(arg0, 9, b"testSUI", b"Test Sui", b"for test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/image.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

