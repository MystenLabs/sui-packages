module 0x98cf8adafffd3c3218bff5793c4404499252cf680841ffe796e0aaddaab9531::abbey {
    struct ABBEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABBEY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ABBEY>(arg0, 6, b"ABBEY", b"Abbey by SuiAI", b"Develop the most advanced autonomous and self-learning AI system within the SUI platform. Integrate this system with other blockchain networks such as Solana and BASE to establish a decentralized ecosystem where success is shared and rewarded collectively.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sui_ai_34abaf6d9a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ABBEY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABBEY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

