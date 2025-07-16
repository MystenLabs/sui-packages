module 0x4d118677c679a7eacdcce5aee185a5c2babef59673911ad1b0f30fc2358a85ae::Test_Token {
    struct TEST_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN>(arg0, 9, b"TEST", b"Test Token", b"Test description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://example.com/icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

