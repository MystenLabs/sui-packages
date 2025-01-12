module 0x53f331d267a1b97c434dfe43f1b636757df3e1e8dc25f35b2e53149f856502ed::lulu {
    struct LULU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LULU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LULU>(arg0, 6, b"LULU", b"LULU Pomeranian by SuiAI", b"ADOPT LOVE, ADOPT LULU!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Whats_App_Image_2025_01_12_at_18_42_05_bb4c84db85.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LULU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LULU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

