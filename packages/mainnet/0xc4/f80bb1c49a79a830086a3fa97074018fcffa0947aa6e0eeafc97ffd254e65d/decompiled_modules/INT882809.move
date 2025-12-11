module 0xc4f80bb1c49a79a830086a3fa97074018fcffa0947aa6e0eeafc97ffd254e65d::INT882809 {
    struct INT882809 has drop {
        dummy_field: bool,
    }

    fun init(arg0: INT882809, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<INT882809>(arg0, 9, 0x1::string::utf8(b"INT882809"), 0x1::string::utf8(b"Integration Test 1765472882809"), 0x1::string::utf8(b"Full integration test token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<INT882809>>(0x2::coin_registry::finalize<INT882809>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<INT882809>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INT882809>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INT882809>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

