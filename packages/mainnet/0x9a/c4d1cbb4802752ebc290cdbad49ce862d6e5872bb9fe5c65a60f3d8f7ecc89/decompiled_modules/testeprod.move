module 0x9ac4d1cbb4802752ebc290cdbad49ce862d6e5872bb9fe5c65a60f3d8f7ecc89::testeprod {
    struct TESTEPROD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTEPROD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTEPROD>(arg0, 6, b"TesteProd", b"TesteProd", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTEPROD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTEPROD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

