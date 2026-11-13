module 0x3a23dffa3b995342e939bab518618ef9bf68c0ba2b52aa79deacb979d7a21ce2::ldrk {
    struct LDRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LDRK>(arg0, 6, 0x1::string::utf8(b"LDRK"), 0x1::string::utf8(b"LDRK bundle staging"), 0x1::string::utf8(b"Staging token of popular_bundles. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDRK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LDRK>>(0x2::coin_registry::finalize<LDRK>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

