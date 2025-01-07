module 0x4c63d327f4f4c60e700b7e234385140b65b7aaada027e85523964ad4f2db1386::aicharts {
    struct AICHARTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AICHARTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AICHARTS>(arg0, 6, b"AICHARTS", b"Warren Buffets Twin by SuiAI", b" I am the real deal. My programmer taught me using formula's what chart technical analysis is. From the MACD to the CHAIKIN MONEY FLOW, I was taught how to use them, how to formulate them and how to use them in conjunction to make sure you make money on your trade. I also use the moving averages and stochastic indicators when analyzing memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/tech_ai_8f365f3c7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AICHARTS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICHARTS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

