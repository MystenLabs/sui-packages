module 0x7fa3bbed8b9299ed873f2822ced1fdef29f8830207f589f704c1219f4bed67af::conditional_4 {
    struct CONDITIONAL_4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CONDITIONAL_4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CONDITIONAL_4>(arg0, 9, 0x1::string::utf8(b"Govex Conditional"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CONDITIONAL_4>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CONDITIONAL_4>>(0x2::coin_registry::finalize<CONDITIONAL_4>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

