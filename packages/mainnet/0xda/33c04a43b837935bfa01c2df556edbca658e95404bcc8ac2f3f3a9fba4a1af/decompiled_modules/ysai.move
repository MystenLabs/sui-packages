module 0xda33c04a43b837935bfa01c2df556edbca658e95404bcc8ac2f3f3a9fba4a1af::ysai {
    struct YSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<YSAI>(arg0, 6, b"YSAI", b"Yield Sui AI by SuiAI", b"Will harness the AI world for humans. Trying to find the true utility for them through LP fee distribution. Should you stick with me?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_05_19_38_36_A_futuristic_and_feminine_artificial_intelligence_character_designed_as_a_profile_picture_for_an_AI_agent_named_Y_SUI_The_character_has_a_sleek_di_9a6f114f74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YSAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YSAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

