module 0xe7eb8a9d04b748a773e128160fc6fe324c15a1558748a110de6b99693ae2aea4::tok {
    struct TOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOK>(arg0, 6, b"TOK", b"TIK by SuiAI", b"TIK TOK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_16_13_22_06_A_modern_logo_design_for_the_word_ART_in_bold_creative_typography_The_text_is_stylized_with_a_gradient_blend_of_vibrant_colors_including_shades_o_c3522cea82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

