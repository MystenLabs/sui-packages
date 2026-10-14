module 0x561e0c63da6abd7a06752abc9f197caf6463e664660b7d6531f512d11edf97ef::sintc {
    struct SINTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SINTC>(arg0, 8, 0x1::string::utf8(b"sINTC"), 0x1::string::utf8(b"Intel xSpot"), 0x1::string::utf8(b"One coin per Intel xStock (INTCx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the INTCx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/intc.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINTC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SINTC>>(0x2::coin_registry::finalize<SINTC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

