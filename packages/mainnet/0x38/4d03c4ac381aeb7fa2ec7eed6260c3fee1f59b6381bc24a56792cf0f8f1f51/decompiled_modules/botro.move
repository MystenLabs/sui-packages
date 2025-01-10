module 0x384d03c4ac381aeb7fa2ec7eed6260c3fee1f59b6381bc24a56792cf0f8f1f51::botro {
    struct BOTRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTRO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BOTRO>(arg0, 6, b"BOTRO", b"Botro - Ai agent & Trading bot on sui by SuiAI", b"Building $BOTRO, the AI Agent & Launch Botro Bot Trading. Faster bot for crypto trading.  Support all route. Automatic Take-Profit & Stop-Loss - Presenting AutoSell Profiles/Copytrade", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_10_001522_494332783f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOTRO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTRO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

