module 0x3d57a64f9cf99abcb348f3533aff988d7852099052440748f61fad13e6652db1::SQRTL {
    struct SQRTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQRTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SQRTL>(arg0, 9, 0x1::string::utf8(b"SQRTL"), 0x1::string::utf8(b"TEMPLATE_NAME"), 0x1::string::utf8(b"Template currency for deployment"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SQRTL>>(0x2::coin_registry::finalize<SQRTL>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQRTL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

