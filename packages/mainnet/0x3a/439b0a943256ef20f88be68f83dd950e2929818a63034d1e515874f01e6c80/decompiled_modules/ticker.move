module 0x3a439b0a943256ef20f88be68f83dd950e2929818a63034d1e515874f01e6c80::ticker {
    struct TICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKER, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<TICKER>(arg0, 5260519624592687946, b"random ticker", b"ticker", b"hi hop", b"https://images.hop.ag/ipfs/QmZQkZurS5eJCYFVwgBCrVTj1efnSKAd6DtGHCrMUDTDtQ", 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), arg1);
    }

    // decompiled from Move bytecode v6
}

