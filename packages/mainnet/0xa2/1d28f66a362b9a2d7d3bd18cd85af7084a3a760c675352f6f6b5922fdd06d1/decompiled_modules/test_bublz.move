module 0xa21d28f66a362b9a2d7d3bd18cd85af7084a3a760c675352f6f6b5922fdd06d1::test_bublz {
    struct TEST_BUBLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_BUBLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_BUBLZ>(arg0, 9, b"tBUBLZ", b"Test BUBLZ", b"Test BUBLZ token for Bubcoin game testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bublz.fun/bublz-logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_BUBLZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_BUBLZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

