module 0xa5ea147749b9d729077a0e53ab1e9fbec0c7c01f1ca2185f9e8edaf7aab769f5::JMASH {
    struct JMASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<JMASH>(arg0, 9, 0x1::string::utf8(b"JMASH"), 0x1::string::utf8(b"Jmash"), 0x1::string::utf8(x"4a6d61736820746f6b656e202d2074686520756e73746f707061626c6520666f72636520696e204465466920f09f94a5"), 0x1::string::utf8(b""), arg1);
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

