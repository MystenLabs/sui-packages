module 0xe03952b604b1a0f3e99ee9024015757ca32ab691275893d03d81e53687e2f380::JMASH {
    struct JMASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<JMASH>(arg0, 9, 0x1::string::utf8(b"JMASH"), 0x1::string::utf8(b"Jmash"), 0x1::string::utf8(x"4a6d61736820746f6b656e202d206275696c7420646966666572656e742c20737461636b696e6720696e66696e69746520f09f928e"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<JMASH>>(0x2::coin_registry::finalize<JMASH>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JMASH>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMASH>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMASH>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

