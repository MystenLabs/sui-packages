module 0xa70bf9f3582414456a0fe35265cfe5e89ffe939119dc85a451dd41ba499697fb::INT378501 {
    struct INT378501 has drop {
        dummy_field: bool,
    }

    fun init(arg0: INT378501, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<INT378501>(arg0, 9, 0x1::string::utf8(b"INT378501"), 0x1::string::utf8(b"Integration Test 1765474378501"), 0x1::string::utf8(b"Full integration test token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<INT378501>>(0x2::coin_registry::finalize<INT378501>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<INT378501>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INT378501>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INT378501>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

