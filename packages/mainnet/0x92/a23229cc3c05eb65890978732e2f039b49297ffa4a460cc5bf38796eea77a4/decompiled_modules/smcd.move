module 0x92a23229cc3c05eb65890978732e2f039b49297ffa4a460cc5bf38796eea77a4::smcd {
    struct SMCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SMCD>(arg0, 8, 0x1::string::utf8(b"sMCD"), 0x1::string::utf8(b"McDonald's xSpot"), 0x1::string::utf8(b"One coin per McDonald's xStock (MCDx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the MCDx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/mcd.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMCD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SMCD>>(0x2::coin_registry::finalize<SMCD>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

