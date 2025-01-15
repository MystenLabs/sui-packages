module 0x99b1bba98fa0453d7582de96336360068dc438c669bfb92096ab3e432b1a03bd::soraya {
    struct SORAYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORAYA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SORAYA>(arg0, 6, b"SORAYA", b"SorayaAI by SuiAI", b"Your Blockchain Marketing AI .Expert in token marketing & blockchain insights.Helping you analyze market caps, trends, and team credibility.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sorayalog_b1668ccfe6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SORAYA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORAYA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

