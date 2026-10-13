module 0x259f45288a9d1f24bf99fef9d816a73949cc188f5996d89b02738eb37fa8d5e6::sbrkb {
    struct SBRKB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBRKB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SBRKB>(arg0, 8, 0x1::string::utf8(b"sBRK.B"), 0x1::string::utf8(b"Berkshire Hathaway B xSpot"), 0x1::string::utf8(b"One coin per Berkshire Hathaway B xStock (BRK.Bx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the BRK.Bx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/brk.b.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBRKB>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SBRKB>>(0x2::coin_registry::finalize<SBRKB>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

