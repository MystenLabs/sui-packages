module 0x4f7ad77f2d82e2f08426ca5d404ee4fb25abc658fe9ccd6dd578fbd00453301e::sspy {
    struct SSPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SSPY>(arg0, 8, 0x1::string::utf8(b"sSPY"), 0x1::string::utf8(b"SPDR S&P 500 ETF xSpot"), 0x1::string::utf8(b"One coin per SPDR S&P 500 ETF xStock (SPYx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the SPYx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/spy.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSPY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SSPY>>(0x2::coin_registry::finalize<SSPY>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

