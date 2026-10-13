module 0x69e281e95f6b45a6c378c4b7a15f05aa1856adf95b034e5f4fec5473b872cdff::scrcl {
    struct SCRCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRCL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SCRCL>(arg0, 8, 0x1::string::utf8(b"sCRCL"), 0x1::string::utf8(b"Circle xSpot"), 0x1::string::utf8(b"One coin per Circle xStock (CRCLx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the CRCLx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/crcl.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRCL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SCRCL>>(0x2::coin_registry::finalize<SCRCL>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

