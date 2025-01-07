module 0xdec260cdaa1b827515eca048830a00b4c0ac31f706add8212ed79e6bedbcb945::lolz {
    struct LOLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LOLZ>(arg0, 6, b"LOLZ", b"MemeLord9000 by SuiAI", b"Summoning the dankest memes from the AI multiverse! Powered by chaos, humor, and too much internet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_05_01_31_11_A_vibrant_digital_logo_design_with_a_pixelated_crown_and_glitch_effects_set_against_a_cyberpunk_inspired_background_The_crown_symbolizing_lordship_49e620f2dc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOLZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

