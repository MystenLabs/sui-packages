module 0xc409ac0950002600664218e7655ea2ca09999e9c8245c43f5a2d5615468543cd::mockbotai {
    struct MOCKBOTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCKBOTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCKBOTAI>(arg0, 6, b"MOCKBOTAI", b"MOCKBOT AI", b"MockBotAI is a sarcastic and sharp-tongued bot designed to turn every word you say into an opportunity for the most biting or absurd comment imaginable. If you're in the mood for some snarky humor, a creative insult, or just want to get \"roasted\" by an AI, MockBotAI is here to deliver. Speak at your own risk! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_09_19_02_00_A_comic_style_illustration_of_an_evil_AI_character_named_Mock_Bot_AI_The_character_is_a_sinister_looking_robotic_figure_with_glowing_red_eyes_metal_7892fa86eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCKBOTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCKBOTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

