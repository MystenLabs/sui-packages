module 0x831a2e4277e86eb6090f4ae115adddb43bfec8a0e687f277fb346d2c6773dbdf::aisui {
    struct AISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AISUI>(arg0, 6, b"AISUI", b"ai16SUI by SuiAI", b"This is a meme token. Only using it for tests. Do not buy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_05_13_03_39_A_futuristic_anime_style_mascot_for_the_project_ai16sui_featuring_a_sleek_and_advanced_AI_concept_The_character_is_a_young_anime_girl_with_futuris_7f9498bb5c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AISUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

