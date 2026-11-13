module 0xecb8298f88189771d16541a624e5db872a0de38cb83b6e0cba94444b08bbec7a::ldru {
    struct LDRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LDRU>(arg0, 6, 0x1::string::utf8(b"LDRU"), 0x1::string::utf8(b"LDRU bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDRU>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LDRU>>(0x2::coin_registry::finalize<LDRU>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

