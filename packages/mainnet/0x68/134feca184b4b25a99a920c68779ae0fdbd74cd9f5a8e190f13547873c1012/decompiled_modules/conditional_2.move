module 0x68134feca184b4b25a99a920c68779ae0fdbd74cd9f5a8e190f13547873c1012::conditional_2 {
    struct CONDITIONAL_2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONDITIONAL_2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CONDITIONAL_2>(arg0, 9, 0x1::string::utf8(b"Govex Conditional"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONDITIONAL_2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CONDITIONAL_2>>(0x2::coin_registry::finalize<CONDITIONAL_2>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

