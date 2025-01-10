module 0x319ec56941305cd0e9f548dde9a4e135f4316011de471dd245d30a678718ba36::testing {
    struct TESTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TESTING>(arg0, 6, b"TESTING", b"TESTING by SuiAI", b"TESTING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_03_10_33_12_A_creative_logo_designed_using_a_pill_shape_as_the_main_element_The_pill_is_stylized_with_vibrant_futuristic_colors_like_neon_blue_and_pink_an_Photoroom_3bc716e1fe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TESTING>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTING>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

