module 0x2fbfef42dedaee8727803cd748a20dde28e8d3adf0c2f4f6e2042ebd92136d26::Test_Wrapper_Token {
    struct TEST_WRAPPER_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_WRAPPER_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_WRAPPER_TOKEN>(arg0, 9, b"TWT", b"Test Wrapper Token", b"Testing the Python wrapper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_WRAPPER_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_WRAPPER_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

