module 0xdd067fa12b9f262e300fda99bb038586f3fad518b6b93d9609757143bd0db0d9::art {
    struct ART has drop {
        dummy_field: bool,
    }

    fun init(arg0: ART, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ART>(arg0, 6, b"ART", b"ART by SuiAI", b"ART COIN for your beautiful art works ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_16_13_22_06_A_modern_logo_design_for_the_word_ART_in_bold_creative_typography_The_text_is_stylized_with_a_gradient_blend_of_vibrant_colors_including_shades_o_ea5333a023.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ART>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ART>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

