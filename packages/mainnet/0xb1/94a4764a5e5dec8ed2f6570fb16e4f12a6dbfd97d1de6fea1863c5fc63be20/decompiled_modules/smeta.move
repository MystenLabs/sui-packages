module 0xb194a4764a5e5dec8ed2f6570fb16e4f12a6dbfd97d1de6fea1863c5fc63be20::smeta {
    struct SMETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SMETA>(arg0, 8, 0x1::string::utf8(b"sMETA"), 0x1::string::utf8(b"Meta Platforms xSpot"), 0x1::string::utf8(b"One coin per Meta Platforms xStock (METAx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the METAx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/meta.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMETA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SMETA>>(0x2::coin_registry::finalize<SMETA>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

