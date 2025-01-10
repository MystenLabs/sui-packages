module 0xa6fa9b4606636c405973dc870122f9293ff71fdeccb929ca5987affa8287141::ffff {
    struct FFFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFFF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FFFF>(arg0, 6, b"FFFF", b"FFFF by SuiAI", b"FFFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_03_10_33_12_A_creative_logo_designed_using_a_pill_shape_as_the_main_element_The_pill_is_stylized_with_vibrant_futuristic_colors_like_neon_blue_and_pink_an_Photoroom_59b7015452.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FFFF>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFFF>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

