module 0xf920f304b6381fcd37b80e531157db06fa33ea72e6868fe19977acd928ba8c23::amphold {
    struct AMPHOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMPHOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AMPHOLD>(arg0, 6, 0x1::string::utf8(b"AMPHOLD"), 0x1::string::utf8(b"Amped staging test Holders"), 0x1::string::utf8(b"Staging test coin for popular_amped. Not a product."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMPHOLD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AMPHOLD>>(0x2::coin_registry::finalize<AMPHOLD>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

