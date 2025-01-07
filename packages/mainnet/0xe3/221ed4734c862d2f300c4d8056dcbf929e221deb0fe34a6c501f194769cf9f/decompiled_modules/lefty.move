module 0xe3221ed4734c862d2f300c4d8056dcbf929e221deb0fe34a6c501f194769cf9f::lefty {
    struct LEFTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEFTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEFTY>(arg0, 6, b"Lefty", b"HangsLow", b"No socials.  No website.  Below the rug.  Liquidity position burns.  Merch cumming.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735928315718.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEFTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEFTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

