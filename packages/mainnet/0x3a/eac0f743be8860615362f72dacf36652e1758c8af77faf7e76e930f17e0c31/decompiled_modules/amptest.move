module 0x3aeac0f743be8860615362f72dacf36652e1758c8af77faf7e76e930f17e0c31::amptest {
    struct AMPTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMPTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AMPTEST>(arg0, 6, 0x1::string::utf8(b"AMPTEST"), 0x1::string::utf8(b"Amped staging test"), 0x1::string::utf8(b"Staging test coin for popular_amped. Not a product."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMPTEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AMPTEST>>(0x2::coin_registry::finalize<AMPTEST>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

