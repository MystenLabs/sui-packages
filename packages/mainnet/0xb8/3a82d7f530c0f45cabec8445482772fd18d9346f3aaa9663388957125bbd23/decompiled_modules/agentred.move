module 0xb83a82d7f530c0f45cabec8445482772fd18d9346f3aaa9663388957125bbd23::agentred {
    struct AGENTRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGENTRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENTRED>(arg0, 6, b"AGENTRED", b"AGENT RED", b"MEMECOIN ON SUI, WORKING ON A DAILY REWARDS BOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_11_15_52_20_A_vibrant_cartoon_style_image_featuring_a_red_toned_frog_with_a_secret_agent_theme_The_frog_is_wearing_a_sleek_black_suit_with_a_red_tie_dark_sungla_ee7f727fb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENTRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGENTRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

