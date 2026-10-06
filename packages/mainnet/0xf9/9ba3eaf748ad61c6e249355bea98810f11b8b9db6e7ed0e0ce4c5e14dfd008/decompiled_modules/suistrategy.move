module 0xf99ba3eaf748ad61c6e249355bea98810f11b8b9db6e7ed0e0ce4c5e14dfd008::suistrategy {
    struct SUISTRATEGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTRATEGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUISTRATEGY>(arg0, 6, 0x1::string::utf8(b"SuiStrategy"), 0x1::string::utf8(b"Sui Strategy"), 0x1::string::utf8(b"Sui Strategy = dev bond + all supply sent to Adeniyi"), 0x1::string::utf8(b"https://fartpadsui.fun/token-images/sui-strategy.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTRATEGY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUISTRATEGY>>(0x2::coin_registry::finalize<SUISTRATEGY>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

