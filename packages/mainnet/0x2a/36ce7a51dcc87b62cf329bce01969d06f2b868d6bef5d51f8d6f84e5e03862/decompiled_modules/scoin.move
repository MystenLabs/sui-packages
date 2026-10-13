module 0x2a36ce7a51dcc87b62cf329bce01969d06f2b868d6bef5d51f8d6f84e5e03862::scoin {
    struct SCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SCOIN>(arg0, 8, 0x1::string::utf8(b"sCOIN"), 0x1::string::utf8(b"Coinbase xSpot"), 0x1::string::utf8(b"One coin per Coinbase xStock (COINx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the COINx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/coin.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SCOIN>>(0x2::coin_registry::finalize<SCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

