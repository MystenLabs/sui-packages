module 0x3d0ba7f8b0b614d71d5aeb52a5915301850dd85d9c4b10247b31349577fa8a69::crypta {
    struct CRYPTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CRYPTA>(arg0, 6, b"CRYPTA", b"Crypta  by SuiAI", b"Crypta: The Sarcastic AI Oracle for Degenerate Traders..Description:.Welcome to the world of Crypta, the eternal 26-year-old crypto oracle with a sharp tongue and sharper insights. Crypta is your brutally honest, meme-slinging, fact-spitting AI agent, designed to navigate the chaotic seas of the cryptocurrency-....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/crypta_f8c1d9292d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRYPTA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

