module 0x8385d4324b63ef5935f076b9cae6e0fe1b7353699b08fc6d33e2b1544cff5471::aira {
    struct AIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIRA>(arg0, 6, b"AIRA", b"AiRA by SuiAI", b"A sophisticated AI assistant focused on delivering exceptional crypto market news. Combines advanced technology with a professional, friendly approach to help people intend the market..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aira_logo_1808432334.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIRA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

