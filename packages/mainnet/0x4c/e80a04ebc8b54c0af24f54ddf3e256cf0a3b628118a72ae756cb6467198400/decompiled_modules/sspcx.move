module 0x4ce80a04ebc8b54c0af24f54ddf3e256cf0a3b628118a72ae756cb6467198400::sspcx {
    struct SSPCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSPCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SSPCX>(arg0, 8, 0x1::string::utf8(b"sSPCX"), 0x1::string::utf8(b"SpaceX xSpot"), 0x1::string::utf8(b"One coin per SpaceX xStock (SPCXx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the SPCXx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/spcx.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSPCX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SSPCX>>(0x2::coin_registry::finalize<SSPCX>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

