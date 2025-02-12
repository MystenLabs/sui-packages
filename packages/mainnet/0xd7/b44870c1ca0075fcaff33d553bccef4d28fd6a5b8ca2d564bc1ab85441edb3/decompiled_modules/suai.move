module 0xd7b44870c1ca0075fcaff33d553bccef4d28fd6a5b8ca2d564bc1ab85441edb3::suai {
    struct SUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUAI>(arg0, 6, b"SUAI", b"SUAI by SuiAI", b"SUAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_02_12_12_26_31_A_modern_and_sleek_cryptocurrency_logo_for_SUAI_token_The_logo_features_a_futuristic_minimalistic_design_with_a_combination_of_blue_and_silver_color_00357d7f90.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

