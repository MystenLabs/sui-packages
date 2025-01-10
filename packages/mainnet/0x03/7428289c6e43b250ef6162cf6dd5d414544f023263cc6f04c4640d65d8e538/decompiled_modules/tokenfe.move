module 0x37428289c6e43b250ef6162cf6dd5d414544f023263cc6f04c4640d65d8e538::tokenfe {
    struct TOKENFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENFE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKENFE>(arg0, 6, b"TOKENFE", b"TOKENFE by SuiAI", b"TOKENFE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_03_10_33_12_A_creative_logo_designed_using_a_pill_shape_as_the_main_element_The_pill_is_stylized_with_vibrant_futuristic_colors_like_neon_blue_and_pink_an_Photoroom_f90cf9f9ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKENFE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENFE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

