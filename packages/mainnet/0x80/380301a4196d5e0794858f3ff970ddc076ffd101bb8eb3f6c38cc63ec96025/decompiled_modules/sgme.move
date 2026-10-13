module 0x80380301a4196d5e0794858f3ff970ddc076ffd101bb8eb3f6c38cc63ec96025::sgme {
    struct SGME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SGME>(arg0, 8, 0x1::string::utf8(b"sGME"), 0x1::string::utf8(b"GameStop xSpot"), 0x1::string::utf8(b"One coin per GameStop xStock (GMEx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the GMEx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/gme.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGME>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SGME>>(0x2::coin_registry::finalize<SGME>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

