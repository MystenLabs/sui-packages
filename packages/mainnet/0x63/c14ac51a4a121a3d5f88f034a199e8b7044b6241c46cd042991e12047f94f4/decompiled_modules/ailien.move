module 0x63c14ac51a4a121a3d5f88f034a199e8b7044b6241c46cd042991e12047f94f4::ailien {
    struct AILIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AILIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AILIEN>(arg0, 6, b"AILIEN", b"AIlien by SuiAI", b"Ailien is a Sui-friendly extraterrestrial moon resident-based cosmic token that bridges the gap between the Moon and Earth by connecting with Earthlings through an AI agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ai_b514de6a5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AILIEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AILIEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

