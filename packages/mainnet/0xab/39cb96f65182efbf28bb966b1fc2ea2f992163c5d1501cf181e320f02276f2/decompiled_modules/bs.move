module 0xab39cb96f65182efbf28bb966b1fc2ea2f992163c5d1501cf181e320f02276f2::bs {
    struct BS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BS>(arg0, 6, 0x1::string::utf8(b"BS"), 0x1::string::utf8(b"Bluechip Suipump"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BS>>(0x2::coin_registry::finalize<BS>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

