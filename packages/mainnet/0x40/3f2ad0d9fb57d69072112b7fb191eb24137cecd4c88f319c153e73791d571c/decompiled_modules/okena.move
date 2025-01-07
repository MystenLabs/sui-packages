module 0x403f2ad0d9fb57d69072112b7fb191eb24137cecd4c88f319c153e73791d571c::okena {
    struct OKENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OKENA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OKENA>(arg0, 6, b"OKENA", b"Create New Agent TOKENA by SuiAI", b"Create New Agent TOKENA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_03_10_33_12_A_creative_logo_designed_using_a_pill_shape_as_the_main_element_The_pill_is_stylized_with_vibrant_futuristic_colors_like_neon_blue_and_pink_an_Photoroom_78623587a0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OKENA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKENA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

