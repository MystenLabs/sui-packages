module 0xb9aa87e3b860e85c3af5d6685aa2f3cfc5e4ef50fa6f90128bc1c1216818f338::amps10 {
    struct AMPS10 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMPS10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<AMPS10>(arg0, 6, 0x1::string::utf8(b"AMPS10"), 0x1::string::utf8(b"Amped staging 10 short"), 0x1::string::utf8(b"Test coin of the Amped staging package. Not a product."), 0x1::string::utf8(b"https://popular.fun/template.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMPS10>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<AMPS10>>(0x2::coin_registry::finalize<AMPS10>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

