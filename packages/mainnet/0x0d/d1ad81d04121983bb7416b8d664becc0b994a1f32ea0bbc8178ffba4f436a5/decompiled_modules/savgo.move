module 0xdd1ad81d04121983bb7416b8d664becc0b994a1f32ea0bbc8178ffba4f436a5::savgo {
    struct SAVGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SAVGO>(arg0, 8, 0x1::string::utf8(b"sAVGO"), 0x1::string::utf8(b"Broadcom xSpot"), 0x1::string::utf8(b"One coin per Broadcom xStock (AVGOx) token held on Solana by the xSpot vault program. Shares per coin grow with dividends (the AVGOx multiplier)."), 0x1::string::utf8(b"https://v3wtf.perpsplexity.app/assets/stocks/avgo.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVGO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SAVGO>>(0x2::coin_registry::finalize<SAVGO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

