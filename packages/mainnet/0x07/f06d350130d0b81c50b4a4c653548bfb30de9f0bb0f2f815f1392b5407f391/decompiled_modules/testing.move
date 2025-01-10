module 0x7f06d350130d0b81c50b4a4c653548bfb30de9f0bb0f2f815f1392b5407f391::testing {
    struct TESTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTING>(arg0, 6, b"TESTING", b"TESTING by SuiAI", b"TESTING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_03_10_33_12_A_creative_logo_designed_using_a_pill_shape_as_the_main_element_The_pill_is_stylized_with_vibrant_futuristic_colors_like_neon_blue_and_pink_an_Photoroom_28198eced6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTING>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTING>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

