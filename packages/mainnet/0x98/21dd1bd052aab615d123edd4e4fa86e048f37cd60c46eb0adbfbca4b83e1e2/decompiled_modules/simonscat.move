module 0x9821dd1bd052aab615d123edd4e4fa86e048f37cd60c46eb0adbfbca4b83e1e2::simonscat {
    struct SIMONSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMONSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMONSCAT>(arg0, 6, b"SimonsCAT", b"Simon's Cat", b"Simon's CAT on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_07_21_44_30_A_simple_cartoon_style_cat_inspired_by_Simon_s_Cat_featuring_exaggerated_wide_eyes_and_a_playful_expression_The_design_is_minimalist_with_bold_black_dd1c8015f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMONSCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMONSCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

