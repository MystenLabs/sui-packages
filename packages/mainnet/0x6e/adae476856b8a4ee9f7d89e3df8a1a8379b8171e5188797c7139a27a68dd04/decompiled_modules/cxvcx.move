module 0x6eadae476856b8a4ee9f7d89e3df8a1a8379b8171e5188797c7139a27a68dd04::cxvcx {
    struct CXVCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CXVCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CXVCX>(arg0, 9, 0x1::string::utf8(b"CXVCX"), 0x1::string::utf8(b"cxc"), 0x1::string::utf8(b"cxc (CXVCX)"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CXVCX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CXVCX>>(0x2::coin_registry::finalize<CXVCX>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

