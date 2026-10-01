module 0xc01e7e04f471e9f95f1e13f60d8da73853b29ea77aba1d63d32cd36c49127c1e::popdoge {
    struct POPDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<POPDOGE>(arg0, 6, 0x1::string::utf8(b"POPDOGE"), 0x1::string::utf8(b"Popular Doge"), 0x1::string::utf8(b"its the most popular doge on sui"), 0x1::string::utf8(b"https://popularsui.xyz/media/f0e4ac04159811b243a2a5e5feae58607d50665171c68a6f37c323305345c61d.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPDOGE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<POPDOGE>>(0x2::coin_registry::finalize<POPDOGE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

