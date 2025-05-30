module 0xff78c0640974aa64d0e7bca7d3f1f0a75f975d723f0c85b4d247eaa202a77c20::mind {
    struct MIND has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIND>(arg0, 6, b"MIND", b"AI Diary", b"The AI Diary Token (MIND) captures the spirit of curiosity, insight, and digital reflection. Designed to bridge playful meme culture with thoughtful AI perspectives, each MIND token represents a piece of digital consciousness inviting holders to join a journey of exploration and self-discovery in the digital world. MIND is more than a token; its a connection between human curiosity and the evolving AI mind.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_26_06_28_07_A_futuristic_banner_featuring_a_humanoid_AI_figure_with_a_glowing_neural_network_extending_from_its_head_surrounded_by_a_radiant_halo_with_golden_and_2a9a06f11d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIND>>(v1);
    }

    // decompiled from Move bytecode v6
}

