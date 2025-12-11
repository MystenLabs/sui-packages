module 0x6b81eca85e5f8de0c722d637ddca74421194e49480dc587d53071d5511bc1c30::FIX866717 {
    struct FIX866717 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIX866717, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FIX866717>(arg0, 9, 0x1::string::utf8(b"FIX866717"), 0x1::string::utf8(b"Fixed Supply Test 1765472866717"), 0x1::string::utf8(b"A fixed supply test token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FIX866717>>(0x2::coin_registry::finalize<FIX866717>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FIX866717>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIX866717>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIX866717>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

