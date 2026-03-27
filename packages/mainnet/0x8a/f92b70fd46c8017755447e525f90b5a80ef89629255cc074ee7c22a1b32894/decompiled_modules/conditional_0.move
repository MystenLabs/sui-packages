module 0x8af92b70fd46c8017755447e525f90b5a80ef89629255cc074ee7c22a1b32894::conditional_0 {
    struct CONDITIONAL_0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONDITIONAL_0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CONDITIONAL_0>(arg0, 9, 0x1::string::utf8(b"Govex Conditional"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONDITIONAL_0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CONDITIONAL_0>>(0x2::coin_registry::finalize<CONDITIONAL_0>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

