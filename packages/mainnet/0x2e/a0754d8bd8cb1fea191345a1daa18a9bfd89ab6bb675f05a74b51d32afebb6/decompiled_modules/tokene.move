module 0x2ea0754d8bd8cb1fea191345a1daa18a9bfd89ab6bb675f05a74b51d32afebb6::tokene {
    struct TOKENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKENE>(arg0, 6, b"TOKENE", b"TOKENE by SuiAI", b"TOKENE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_03_10_33_12_A_creative_logo_designed_using_a_pill_shape_as_the_main_element_The_pill_is_stylized_with_vibrant_futuristic_colors_like_neon_blue_and_pink_an_Photoroom_b0ea561691.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKENE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

