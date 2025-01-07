module 0xaf05861a591cb8164de29f7a3e4eae52473e46a7c462a902f672b701267377d2::suirari {
    struct SUIRARI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRARI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRARI>(arg0, 6, b"SuiRari", b"SUIRARI", b"ferrari on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_07_23_16_41_A_logo_inspired_by_the_luxury_and_speed_of_a_Ferrari_but_themed_around_the_SUI_network_The_design_features_a_sleek_stylized_horse_in_a_dynamic_pose_f7e0d0e54e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRARI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRARI>>(v1);
    }

    // decompiled from Move bytecode v6
}

