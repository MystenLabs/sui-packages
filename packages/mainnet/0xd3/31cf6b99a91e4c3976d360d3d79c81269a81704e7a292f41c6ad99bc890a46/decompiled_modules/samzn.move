module 0xd331cf6b99a91e4c3976d360d3d79c81269a81704e7a292f41c6ad99bc890a46::samzn {
    struct SAMZN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMZN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SAMZN>(arg0, 8, 0x1::string::utf8(b"sAMZN"), 0x1::string::utf8(b"Amazon xSpot"), 0x1::string::utf8(b"One coin per Amazon xStock (AMZNx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the AMZNx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/amzn.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMZN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SAMZN>>(0x2::coin_registry::finalize<SAMZN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

