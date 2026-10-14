module 0x5a9877c347b22e227d100f21bd9152a3ea311128fdd70b6cb0f4a19c71ef35b6::ampb9 {
    struct AMPB9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMPB9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AMPB9>(arg0, 6, 0x1::string::utf8(b"AMPB9"), 0x1::string::utf8(b"Amped basket staging 9"), 0x1::string::utf8(b"Test coin of the Amped staging package. Not a product."), 0x1::string::utf8(b"https://popular.fun/template.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMPB9>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AMPB9>>(0x2::coin_registry::finalize<AMPB9>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

