module 0xb84977f0d7d1439d0dde454b03a5d96111b8a9c1196e43d43974f6a39e6e4dd::traidar {
    struct TRAIDAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAIDAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRAIDAR>(arg0, 6, b"TRAIDAR", b"Traiding Radar by SuiAI", b"Wilson, is an AI developed by a team of source-code and python developers as their first development on chain, the bot is ruthless and transparent about the best events and best investment bags to do on the top10 cryptos for now (updates will come)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/AI_fd0e8a86cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRAIDAR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAIDAR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

