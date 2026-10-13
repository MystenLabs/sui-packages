module 0x4574e08a46efa14349d083d589bb5fb9987363d9df2439c703e471f9cc060398::ampv3 {
    struct AMPV3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMPV3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AMPV3>(arg0, 6, 0x1::string::utf8(b"AMPV3"), 0x1::string::utf8(b"Amped staging 8"), 0x1::string::utf8(b"Test coin of the Amped staging package. Not a product."), 0x1::string::utf8(b"https://popular.fun/template.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMPV3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AMPV3>>(0x2::coin_registry::finalize<AMPV3>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

