module 0xabe129f638cc280651f7005aa7c1fb5ae98f67cd954c3f21aed9d07fed8f42a6::FLX780153 {
    struct FLX780153 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLX780153, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FLX780153>(arg0, 9, 0x1::string::utf8(b"FLX780153"), 0x1::string::utf8(b"Flexible Test 1765472780153"), 0x1::string::utf8(b"A flexible supply test token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FLX780153>>(0x2::coin_registry::finalize<FLX780153>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FLX780153>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLX780153>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLX780153>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

