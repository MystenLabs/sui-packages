module 0x7efe76ce8f8d7f41288d5f9ec7868c5f4194e643dcb893a865a023494adb33e::Simple_Test_Token {
    struct SIMPLE_TEST_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPLE_TEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPLE_TEST_TOKEN>(arg0, 9, b"SIMPLE", b"Simple Test Token", b"A simple test token created with Kappa SDK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIMPLE_TEST_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPLE_TEST_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

