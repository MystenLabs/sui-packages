module 0xe73744028f58038f141bd6d8f5edc9fa8b8441d112cbae5dca25529c2453665f::gusd2 {
    struct GUSD2 has drop {
        dummy_field: bool,
    }

    public fun finalize_registration(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<GUSD2>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<GUSD2>(arg0, arg1, arg2);
    }

    fun init(arg0: GUSD2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GUSD2>(arg0, 9, 0x1::string::utf8(b"GUSD2"), 0x1::string::utf8(b"Generalized USD v2"), 0x1::string::utf8(b"Generalized USD vault token v2"), 0x1::string::utf8(b"https://aftermath.finance/gusd.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSD2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GUSD2>>(0x2::coin_registry::finalize<GUSD2>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

