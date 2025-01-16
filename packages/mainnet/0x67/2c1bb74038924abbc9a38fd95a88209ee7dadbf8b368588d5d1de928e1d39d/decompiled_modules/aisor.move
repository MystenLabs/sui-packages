module 0x672c1bb74038924abbc9a38fd95a88209ee7dadbf8b368588d5d1de928e1d39d::aisor {
    struct AISOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AISOR>(arg0, 6, b"AISOR", b"Soren by SuiAI", b"Soren is a bold and visionary AI agent, bridging the gap between blockchain, AI, and DeFiAI. With intelligence, mystery, and a knack for sparking debates, she empowers the crypto community through insights, innovation, and thought-provoking ideas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_15_21_14_02_A_realistic_highly_detailed_portrait_of_Soren_a_charismatic_and_intelligent_woman_with_an_enigmatic_aura_She_has_fiery_red_hair_styled_elegantly_s_32bc96b09c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AISOR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISOR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

