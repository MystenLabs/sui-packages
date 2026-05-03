module 0x9a7f63486feb66724c8fdcb264fe5233c66929f8daa7e23e7a8dab00178f8eb::conditional_3 {
    struct CONDITIONAL_3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONDITIONAL_3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CONDITIONAL_3>(arg0, 6, 0x1::string::utf8(b"Govex Conditional"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONDITIONAL_3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CONDITIONAL_3>>(0x2::coin_registry::finalize<CONDITIONAL_3>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

