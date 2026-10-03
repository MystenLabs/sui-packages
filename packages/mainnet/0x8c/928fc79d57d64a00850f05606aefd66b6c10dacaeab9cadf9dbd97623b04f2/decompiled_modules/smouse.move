module 0x8c928fc79d57d64a00850f05606aefd66b6c10dacaeab9cadf9dbd97623b04f2::smouse {
    struct SMOUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SMOUSE>(arg0, 6, 0x1::string::utf8(b"SMOUSE"), 0x1::string::utf8(b"Suimouse"), 0x1::string::utf8(x"f09f90adf09f92a7204d4f55534520782053554920f09f9299"), 0x1::string::utf8(b"https://popularsui.xyz/media/3285a01c0604211026b0f7623295efd925d24f64038f094942734a815c24e752.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOUSE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SMOUSE>>(0x2::coin_registry::finalize<SMOUSE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

