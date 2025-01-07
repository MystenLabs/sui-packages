module 0x5c458681831c4302e3571bc10798f6dcdd567fbf6f1d7f400faf15791224217a::agent07 {
    struct AGENT07 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENT07, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT07>(arg0, 6, b"AGENT07", b"AGENT ALIEN 007", b"Your Intergalactic Mission Starts with Agent Alien 007!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_27_22_28_44_A_logo_design_for_a_meme_coin_with_an_Agent_007_theme_featuring_a_humorous_alien_character_The_alien_is_depicted_with_a_playful_and_quirky_demeanor_1680f0b2c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT07>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGENT07>>(v1);
    }

    // decompiled from Move bytecode v6
}

