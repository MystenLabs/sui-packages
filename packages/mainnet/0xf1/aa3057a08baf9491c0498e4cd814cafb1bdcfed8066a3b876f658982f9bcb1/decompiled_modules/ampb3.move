module 0xf1aa3057a08baf9491c0498e4cd814cafb1bdcfed8066a3b876f658982f9bcb1::ampb3 {
    struct AMPB3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMPB3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AMPB3>(arg0, 6, 0x1::string::utf8(b"AMPB3"), 0x1::string::utf8(b"Amped basket staging 8"), 0x1::string::utf8(b"Test coin of the Amped staging package. Not a product."), 0x1::string::utf8(b"https://popular.fun/template.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMPB3>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AMPB3>>(0x2::coin_registry::finalize<AMPB3>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

