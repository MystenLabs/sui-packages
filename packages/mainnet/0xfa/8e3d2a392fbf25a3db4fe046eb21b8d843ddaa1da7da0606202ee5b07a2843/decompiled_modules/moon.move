module 0xfa8e3d2a392fbf25a3db4fe046eb21b8d843ddaa1da7da0606202ee5b07a2843::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MOON>(arg0, 6, 0x1::string::utf8(b"MOON"), 0x1::string::utf8(b"MOON bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MOON>>(0x2::coin_registry::finalize<MOON>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

