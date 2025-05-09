module 0x73f91eb410ce39561a56ec010e6216df4342fdae8437e7b4ded80685a9b0a8c::chicken {
    struct CHICKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHICKEN>(arg0, 6, b"CHICKEN", b"Chicken Coin", b"A fun cryptocurrency inspired by everyone's favorite bird - the chicken! [AI Meme - By SuiAI]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/meme/pr2MYY.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHICKEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

