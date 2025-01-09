module 0xef739d980cf0366507d1c2d960b7eb13adb70ff4a46304e89a1b1ef485e4e162::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLD>(arg0, 6, b"GOLD", b"GOLDIE", b"Unlike anything else in the market no AI, no dogs, no cats. Just pure, free-flowing money. A meme coin driven by the market, not the devs. Join the movement and ride the wave to wealth!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_09_15_35_28_A_playful_and_fun_design_for_a_meme_cryptocurrency_project_featuring_a_shiny_golden_coin_with_a_humorous_expression_smiling_face_or_winking_and_a_g_7e40f8b457.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

