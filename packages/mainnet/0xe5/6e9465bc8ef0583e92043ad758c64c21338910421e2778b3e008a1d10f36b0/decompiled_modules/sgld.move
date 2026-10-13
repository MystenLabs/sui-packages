module 0xe56e9465bc8ef0583e92043ad758c64c21338910421e2778b3e008a1d10f36b0::sgld {
    struct SGLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SGLD>(arg0, 8, 0x1::string::utf8(b"sGLD"), 0x1::string::utf8(b"SPDR Gold Shares xSpot"), 0x1::string::utf8(b"One coin per SPDR Gold Shares xStock (GLDx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the GLDx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/gld.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGLD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SGLD>>(0x2::coin_registry::finalize<SGLD>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

