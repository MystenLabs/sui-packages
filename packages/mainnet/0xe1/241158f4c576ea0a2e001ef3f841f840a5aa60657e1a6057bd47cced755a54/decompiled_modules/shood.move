module 0xe1241158f4c576ea0a2e001ef3f841f840a5aa60657e1a6057bd47cced755a54::shood {
    struct SHOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SHOOD>(arg0, 8, 0x1::string::utf8(b"sHOOD"), 0x1::string::utf8(b"Robinhood xSpot"), 0x1::string::utf8(b"One coin per Robinhood xStock (HOODx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the HOODx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/hood.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOOD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SHOOD>>(0x2::coin_registry::finalize<SHOOD>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

