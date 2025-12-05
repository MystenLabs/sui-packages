module 0xaa5909487bd886f43eacf584d54c91f99043cfece3182bb3336330a11e943bfb::gusdt {
    struct GUSDT has drop {
        dummy_field: bool,
    }

    public fun finalize_registration(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<GUSDT>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<GUSDT>(arg0, arg1, arg2);
    }

    fun init(arg0: GUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GUSDT>(arg0, 18, 0x1::string::utf8(b"GUSDT"), 0x1::string::utf8(b"GUSDT"), 0x1::string::utf8(b"GUSDT"), 0x1::string::utf8(b"https://example.com"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSDT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GUSDT>>(0x2::coin_registry::finalize<GUSDT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

