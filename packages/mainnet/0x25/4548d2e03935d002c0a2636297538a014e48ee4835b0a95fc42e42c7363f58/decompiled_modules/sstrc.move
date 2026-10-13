module 0x254548d2e03935d002c0a2636297538a014e48ee4835b0a95fc42e42c7363f58::sstrc {
    struct SSTRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSTRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SSTRC>(arg0, 8, 0x1::string::utf8(b"sSTRC"), 0x1::string::utf8(b"Strategy STRC Preferred xSpot"), 0x1::string::utf8(b"One coin per Strategy STRC Preferred xStock (STRCx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the STRCx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/strc.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSTRC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SSTRC>>(0x2::coin_registry::finalize<SSTRC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

