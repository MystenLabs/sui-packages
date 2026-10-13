module 0x86ee971f9792c7a3df1f8fef4aa2752139ddead1aef3d552bc1dcf0fb49dd738::snvda {
    struct SNVDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNVDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SNVDA>(arg0, 8, 0x1::string::utf8(b"sNVDA"), 0x1::string::utf8(b"NVIDIA xSpot"), 0x1::string::utf8(b"One coin per NVIDIA xStock (NVDAx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the NVDAx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/nvda.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNVDA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SNVDA>>(0x2::coin_registry::finalize<SNVDA>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

