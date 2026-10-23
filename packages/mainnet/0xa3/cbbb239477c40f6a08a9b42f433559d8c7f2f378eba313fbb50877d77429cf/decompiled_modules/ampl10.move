module 0xa3cbbb239477c40f6a08a9b42f433559d8c7f2f378eba313fbb50877d77429cf::ampl10 {
    struct AMPL10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMPL10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AMPL10>(arg0, 6, 0x1::string::utf8(b"AMPL10"), 0x1::string::utf8(b"Amped staging 10 long"), 0x1::string::utf8(b"Test coin of the Amped staging package. Not a product."), 0x1::string::utf8(b"https://popular.fun/template.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMPL10>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AMPL10>>(0x2::coin_registry::finalize<AMPL10>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

