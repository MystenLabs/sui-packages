module 0x38cb7e8f124aca7914cea1eaaab947d031cd2d42621425fa2d485fa8c2a50ca3::spltr {
    struct SPLTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SPLTR>(arg0, 8, 0x1::string::utf8(b"sPLTR"), 0x1::string::utf8(b"Palantir xSpot"), 0x1::string::utf8(b"One coin per Palantir xStock (PLTRx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the PLTRx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/pltr.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLTR>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SPLTR>>(0x2::coin_registry::finalize<SPLTR>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

