module 0xd584e457f8e218a8fd2a2cb9c106772e72650217d3b7c57ec30dff542970defa::saapl {
    struct SAAPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAAPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SAAPL>(arg0, 8, 0x1::string::utf8(b"sAAPL"), 0x1::string::utf8(b"Apple xSpot"), 0x1::string::utf8(b"One coin per Apple xStock (AAPLx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the AAPLx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/aapl.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAAPL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SAAPL>>(0x2::coin_registry::finalize<SAAPL>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

