module 0x1501742f648d9a74696c2641bd8cd20acc5d09c2fde0a5b332b4fd7041603b12::spotifai {
    struct SPOTIFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOTIFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SPOTIFAI>(arg0, 6, b"SPOTIFAI", b"SpotifAI by SuiAI", b"Your AI Intelligence Partner: A cutting-edge, ever-evolving AI agent designed to explore, analyze, and identify the most advanced artificial intelligence tools on the market. With real-time learning and adaptive capabilities, it uncovers hidden opportunities, evaluates the latest breakthroughs, and delivers actionable insights to empower your investment portfolio. Always learning, always improving, this AI is your ultimate guide to navigating the vast and dynamic landscape of artificial intelligence. Stay ahead of the curve with a tireless partner that never stops innovating.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Diseno_sin_titulo_2025_01_14_T231022_462_4a7b6b9bab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPOTIFAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOTIFAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

