module 0xb66e4e1ad29b68337d9228d57d29d15de1a88f8e61b22fbe7ecdb99419359a0d::ampv9 {
    struct AMPV9 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMPV9, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AMPV9>(arg0, 6, 0x1::string::utf8(b"AMPV9"), 0x1::string::utf8(b"Amped staging 9"), 0x1::string::utf8(b"Test coin of the Amped staging package. Not a product."), 0x1::string::utf8(b"https://popular.fun/template.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMPV9>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AMPV9>>(0x2::coin_registry::finalize<AMPV9>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

