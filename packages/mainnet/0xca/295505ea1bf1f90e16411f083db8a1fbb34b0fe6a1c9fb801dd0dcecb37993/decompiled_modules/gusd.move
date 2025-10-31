module 0xca295505ea1bf1f90e16411f083db8a1fbb34b0fe6a1c9fb801dd0dcecb37993::gusd {
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

