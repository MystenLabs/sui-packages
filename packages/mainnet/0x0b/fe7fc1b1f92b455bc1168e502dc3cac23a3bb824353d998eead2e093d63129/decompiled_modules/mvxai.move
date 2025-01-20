module 0xbfe7fc1b1f92b455bc1168e502dc3cac23a3bb824353d998eead2e093d63129::mvxai {
    struct MVXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MVXAI>(arg0, 6, b"MVXAI", b"AI Odds Oracle MVX by SuiAI", b"Odds Oracle MVX is a cutting-edge sports betting AI agent designed for MVX Fundex. It leverages advanced analytics, real-time data, and predictive models to provide smart betting recommendations, odds analysis, and game insights. With a sleek, futuristic vibe, Odds Oracle MVX empowers users to make confident, data-driven bets while staying ahead of the game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2111_a015429c6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MVXAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVXAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

