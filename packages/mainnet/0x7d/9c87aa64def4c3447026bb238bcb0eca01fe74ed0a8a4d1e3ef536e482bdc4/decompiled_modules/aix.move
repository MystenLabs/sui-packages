module 0x7d9c87aa64def4c3447026bb238bcb0eca01fe74ed0a8a4d1e3ef536e482bdc4::aix {
    struct AIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIX>(arg0, 6, b"AIX", b"AIXYZ AGENT by SuiAI", b"AIXYZ AGENT is an intelligent AI agent that provides advanced market analysis, name, ticker and description generation for Crypto and AI projects, and develops innovative ideas for new AI agents. It monitors Twitter to identify emerging trends in Artificial Intelligence, Crypto and the market. It provides unique analysis and accurate forecasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Whats_App_Image_2025_01_12_at_20_33_04_1_2635993993.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

