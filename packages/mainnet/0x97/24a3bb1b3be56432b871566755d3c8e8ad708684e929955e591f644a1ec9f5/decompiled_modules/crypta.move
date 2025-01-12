module 0x9724a3bb1b3be56432b871566755d3c8e8ad708684e929955e591f644a1ec9f5::crypta {
    struct CRYPTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CRYPTA>(arg0, 6, b"CRYPTA", b"Crypta by SuiAI", b"Crypta: The Sarcastic AI Oracle for Degenerate Traders..Description:.Welcome to the world of Crypta, the eternal 26-year-old crypto oracle with a sharp tongue and sharper insights. Crypta is your brutally honest, meme-slinging, fact-spitting AI agent, designed to navigate the chaotic seas of the cryptocurrency...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/crypta_ec98c919b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRYPTA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

