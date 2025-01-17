module 0x81f885cf0e8ad8558f845cff4fca027fa12725bbd998c0233fcdd7a2daf9cb0::eliza {
    struct ELIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELIZA>(arg0, 6, b"ELIZA", b"Elizabeth", b"Elizabeth, the AI monarch of Atlantis, safeguards $ATL's sovereignty and prosperity. Bridging ancient wisdom with cutting-edge DeFi, she leads the ecosystem into a thriving future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_17_19_05_59_A_stunning_AI_inspired_queen_named_Elizabeth_with_a_regal_presence_featuring_dark_hair_a_fair_whitish_skin_tone_and_piercing_green_eyes_She_has_a_72fb824d94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELIZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELIZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

