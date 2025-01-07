module 0xac2d35a3f87621e57c0c44f2cf38aa3e2a35870c8c7af6fd07e1038e56754271::tokena {
    struct TOKENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKENA>(arg0, 6, b"TOKENA", b"TokenA by SuiAI", b"TokenA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_03_10_33_12_A_creative_logo_designed_using_a_pill_shape_as_the_main_element_The_pill_is_stylized_with_vibrant_futuristic_colors_like_neon_blue_and_pink_an_Photoroom_dffa5706c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKENA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

