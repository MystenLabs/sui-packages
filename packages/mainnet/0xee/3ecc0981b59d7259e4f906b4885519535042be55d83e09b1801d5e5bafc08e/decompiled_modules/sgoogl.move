module 0xee3ecc0981b59d7259e4f906b4885519535042be55d83e09b1801d5e5bafc08e::sgoogl {
    struct SGOOGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOOGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SGOOGL>(arg0, 8, 0x1::string::utf8(b"sGOOGL"), 0x1::string::utf8(b"Alphabet xSpot"), 0x1::string::utf8(b"One coin per Alphabet xStock (GOOGLx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the GOOGLx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/googl.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOOGL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SGOOGL>>(0x2::coin_registry::finalize<SGOOGL>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

