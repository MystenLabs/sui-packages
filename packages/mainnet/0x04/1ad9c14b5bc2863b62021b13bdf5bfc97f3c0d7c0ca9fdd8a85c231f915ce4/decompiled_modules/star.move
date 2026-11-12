module 0x41ad9c14b5bc2863b62021b13bdf5bfc97f3c0d7c0ca9fdd8a85c231f915ce4::star {
    struct STAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<STAR>(arg0, 6, 0x1::string::utf8(b"STAR"), 0x1::string::utf8(b"STAR bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<STAR>>(0x2::coin_registry::finalize<STAR>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

