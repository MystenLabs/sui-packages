module 0xcd974044c8a09aab2862f1703749e690bd39c060fdfd45ceb18e7f4e623e3c2d::ldrb {
    struct LDRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LDRB>(arg0, 6, 0x1::string::utf8(b"LDRB"), 0x1::string::utf8(b"LDRB bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDRB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LDRB>>(0x2::coin_registry::finalize<LDRB>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

