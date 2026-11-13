module 0x4c6e8d362ceb6bdda535bfcd54901abb450c03a6b22b24b76fb173ecdd7486de::ldrc {
    struct LDRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LDRC>(arg0, 6, 0x1::string::utf8(b"LDRC"), 0x1::string::utf8(b"LDRC bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDRC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LDRC>>(0x2::coin_registry::finalize<LDRC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

