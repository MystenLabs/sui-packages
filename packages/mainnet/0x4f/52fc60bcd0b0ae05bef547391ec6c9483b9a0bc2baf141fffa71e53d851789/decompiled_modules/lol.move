module 0x4f52fc60bcd0b0ae05bef547391ec6c9483b9a0bc2baf141fffa71e53d851789::lol {
    struct LOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LOL>(arg0, 9, 0x1::string::utf8(b"LOL"), 0x1::string::utf8(b"lol"), 0x1::string::utf8(b"lol (LOL)"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LOL>>(0x2::coin_registry::finalize<LOL>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

