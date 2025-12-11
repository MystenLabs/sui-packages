module 0x2c4b241b4100c100b7d74caa543579a6ae3b8f3f5a37c6d3982c03ada03cfbfb::FIX795408 {
    struct FIX795408 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIX795408, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FIX795408>(arg0, 9, 0x1::string::utf8(b"FIX795408"), 0x1::string::utf8(b"Fixed Supply Test 1765472795408"), 0x1::string::utf8(b"A fixed supply test token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FIX795408>>(0x2::coin_registry::finalize<FIX795408>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FIX795408>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIX795408>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIX795408>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

