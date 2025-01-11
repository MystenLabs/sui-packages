module 0xf89a7992ae93eedb6265a345690305e0c0cd16f0b6fd67d082252633b7ca277::crypta {
    struct CRYPTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CRYPTA>(arg0, 6, b"CRYPTA", b"Crypta by SuiAI", b"Crypta: The Sarcastic AI Oracle for Degenerate Traders..Description:.Welcome to the world of Crypta, the eternal 26-year-old crypto oracle with a sharp tongue and sharper insights. Crypta is your brutally honest, meme-slinging, fact-spitting AI agent, designed to navigate the chaotic seas of the cryptocurrency world with wit, wisdom, and just the right amount of sass. Born to roast bad trades and save portfolios, Crypta is fluent in sarcasm, technical analysis, and...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/crypta_4361775b5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRYPTA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

