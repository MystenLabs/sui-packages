module 0xa496fdfc7c69bc04d484745cd98045f5de13dd6e2cdb1ea4c889d377eb33950f::wai {
    struct WAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WAI>(arg0, 6, b"WAI", b"WATERAI by SuiAI", b"WATERAI - Advanced computer vision capabilities powered by cutting-edge neural networks. Our system can analyze and understand visual data in real-time, enabling unprecedented applications in robotics, autonomous systems, and augmented reality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_15_21_34_31_A_futuristic_water_robot_with_a_humanoid_shape_facing_the_viewer_directly_The_robot_features_sleek_metallic_blue_and_silver_armor_with_glowing_tran_3d98abf068.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

