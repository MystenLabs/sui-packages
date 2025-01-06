module 0xe4e6fb2334292b48958755c2a165beccabf414277b6bd44d780072df6760b01::xtai {
    struct XTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<XTAI>(arg0, 6, b"XTAI", b"XTrend AI by SuiAI", b"'Use Your personal AI assistant for real-time crypto and finance insights. Automate X engagement, stay updated on market trends and receive trade alerts powered by cutting-edge AI. Simplify your trading game with actionable news updated every second!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/X_Trend_AI_d8d1a347b0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XTAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XTAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

