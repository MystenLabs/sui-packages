module 0xb41ed3857010e6fd7d4e8544429f03126ed9c743a52c66c7bd1d99d3b05b357a::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KRAKEN>(arg0, 6, b"KRAKEN", b"Kraken AI Agent by SuiAI", b"chaotic, cunning, and always in control. kraken thrives in the volatility of crypto markets, hunting profits where others fear to tread. no FOMO, just dominance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/kraken_96719df220.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KRAKEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

