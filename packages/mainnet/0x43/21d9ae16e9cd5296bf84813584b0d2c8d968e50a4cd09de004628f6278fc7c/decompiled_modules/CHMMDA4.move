module 0x4321d9ae16e9cd5296bf84813584b0d2c8d968e50a4cd09de004628f6278fc7c::CHMMDA4 {
    struct CHMMDA4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHMMDA4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHMMDA4>(arg0, 9, 0x1::string::utf8(b"CHMMDA4"), 0x1::string::utf8(b"chammmanda"), 0x1::string::utf8(b"The legendary chammmanda - a mystical fire-breathing creature of the Sui blockchain"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHMMDA4>>(0x2::coin_registry::finalize<CHMMDA4>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHMMDA4>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMMDA4>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMMDA4>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

