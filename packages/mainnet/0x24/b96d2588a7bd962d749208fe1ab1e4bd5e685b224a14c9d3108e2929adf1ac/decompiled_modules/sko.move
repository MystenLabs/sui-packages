module 0x24b96d2588a7bd962d749208fe1ab1e4bd5e685b224a14c9d3108e2929adf1ac::sko {
    struct SKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SKO>(arg0, 8, 0x1::string::utf8(b"sKO"), 0x1::string::utf8(b"Coca-Cola xSpot"), 0x1::string::utf8(b"One coin per Coca-Cola xStock (KOx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the KOx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/ko.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SKO>>(0x2::coin_registry::finalize<SKO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

