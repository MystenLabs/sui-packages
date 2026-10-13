module 0xa072b45912f1000930d2bf0e53c582488b368b830c35e39dfcbad9d9fd20a8a3::amps3 {
    struct AMPS3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMPS3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AMPS3>(arg0, 6, 0x1::string::utf8(b"AMPS3"), 0x1::string::utf8(b"Amped snipe staging 8"), 0x1::string::utf8(b"Test coin of the Amped staging package. Not a product."), 0x1::string::utf8(b"https://popular.fun/template.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMPS3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AMPS3>>(0x2::coin_registry::finalize<AMPS3>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

