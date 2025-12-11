module 0xf6ba6d4f5e7c345e31fa9dee47e997c04c84f5cebcbf7410900d58a6841d42da::FIX349955 {
    struct FIX349955 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIX349955, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FIX349955>(arg0, 9, 0x1::string::utf8(b"FIX349955"), 0x1::string::utf8(b"Fixed Supply Test 1765474349955"), 0x1::string::utf8(b"A fixed supply test token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FIX349955>>(0x2::coin_registry::finalize<FIX349955>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FIX349955>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIX349955>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIX349955>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

