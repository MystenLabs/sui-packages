module 0x4548b5c3e5c87c2e4441912664a33c9705cdfe8d292f29759b269d9983d9a9c3::botro {
    struct BOTRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTRO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BOTRO>(arg0, 6, b"BOTRO", b" Botro - Ai agent & Trading bot on sui by SuiAI", b"Building $BOTRO, the AI Agent & Launch Botro Bot Trading. Faster bot for crypto trading. Support all route. Automatic Take-Profit & Stop-Loss - Presenting AutoSell Profiles/Copytrade", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/botro_7acfd4b104.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOTRO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTRO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

