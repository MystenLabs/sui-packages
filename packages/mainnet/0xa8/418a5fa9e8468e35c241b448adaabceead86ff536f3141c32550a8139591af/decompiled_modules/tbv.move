module 0xa8418a5fa9e8468e35c241b448adaabceead86ff536f3141c32550a8139591af::tbv {
    struct TBV has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TBV>(arg0, 6, 0x1::string::utf8(b"TBV"), 0x1::string::utf8(b"TBV bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBV>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TBV>>(0x2::coin_registry::finalize<TBV>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

