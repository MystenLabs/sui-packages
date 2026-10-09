module 0x15796566531fa086954cf6106e5e477388d3313a331c63081880021c99d3bf32::ampvtwo {
    struct AMPVTWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMPVTWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AMPVTWO>(arg0, 6, 0x1::string::utf8(b"AMPVTWO"), 0x1::string::utf8(b"Amped v2 staging"), 0x1::string::utf8(b"Test coin of the Amped v2 staging package. Not a product."), 0x1::string::utf8(b"https://popular.fun/template.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMPVTWO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AMPVTWO>>(0x2::coin_registry::finalize<AMPVTWO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

