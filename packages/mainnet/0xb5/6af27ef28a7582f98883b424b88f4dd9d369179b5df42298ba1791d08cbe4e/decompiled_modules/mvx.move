module 0xb56af27ef28a7582f98883b424b88f4dd9d369179b5df42298ba1791d08cbe4e::mvx {
    struct MVX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MVX>(arg0, 6, b"MVX", b"AI Odds Oracle MVX  by SuiAI", b"Odds Oracle MVX is a cutting-edge sports betting AI agent designed for MVX Fundex. It leverages advanced analytics, real-time data, and predictive models to provide smart betting recommendations, odds analysis, and game insights. With a sleek, futuristic vibe, Odds Oracle MVX empowers users to make confident, data-driven bets while staying ahead of the game..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2111_a015429c6d_79148d2a12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MVX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

