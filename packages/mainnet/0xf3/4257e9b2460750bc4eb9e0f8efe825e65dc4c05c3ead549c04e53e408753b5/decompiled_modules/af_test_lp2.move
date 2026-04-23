module 0xf34257e9b2460750bc4eb9e0f8efe825e65dc4c05c3ead549c04e53e408753b5::af_test_lp2 {
    struct AF_TEST_LP2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_TEST_LP2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AF_TEST_LP2>(arg0, 9, b"afTLP2", b"AF Test LP2", b"Test vault LP2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AF_TEST_LP2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AF_TEST_LP2>>(v1);
    }

    // decompiled from Move bytecode v7
}

