module 0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::credit {
    struct CREDIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREDIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CREDIT>(arg0, 0, 0x1::string::utf8(b"AUC"), 0x1::string::utf8(b"ACT Universal Credits"), 0x1::string::utf8(b"Spend it in the ACT shop on Genesis items and future drops."), 0x1::string::utf8(b""), arg1);
        0xc90ed2fbb74ba735aaaeb86bbe376972a8119c62f4f1d59cf734de6815b9feee::tokens::setup<CREDIT>(v0, v1, arg1);
    }

    // decompiled from Move bytecode v7
}

