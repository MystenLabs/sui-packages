module 0x5d35c54838ee95d65a84bff928db9719b768a25a2789eb7fdd47d24b123c06c8::gusd {
    struct GUSD has drop {
        dummy_field: bool,
    }

    public fun finalize_registration(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<GUSD>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<GUSD>(arg0, arg1, arg2);
    }

    fun init(arg0: GUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GUSD>(arg0, 18, 0x1::string::utf8(b"GUSD"), 0x1::string::utf8(b"GUSD"), 0x1::string::utf8(b"GUSD"), 0x1::string::utf8(b"https://example.com"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUSD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GUSD>>(0x2::coin_registry::finalize<GUSD>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

