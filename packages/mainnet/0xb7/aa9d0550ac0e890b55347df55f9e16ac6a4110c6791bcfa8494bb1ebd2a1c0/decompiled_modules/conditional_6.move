module 0xb7aa9d0550ac0e890b55347df55f9e16ac6a4110c6791bcfa8494bb1ebd2a1c0::conditional_6 {
    struct CONDITIONAL_6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONDITIONAL_6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CONDITIONAL_6>(arg0, 9, 0x1::string::utf8(b"Govex Conditional"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONDITIONAL_6>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CONDITIONAL_6>>(0x2::coin_registry::finalize<CONDITIONAL_6>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

