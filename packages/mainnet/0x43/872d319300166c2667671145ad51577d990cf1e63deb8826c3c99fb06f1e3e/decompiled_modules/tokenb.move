module 0x43872d319300166c2667671145ad51577d990cf1e63deb8826c3c99fb06f1e3e::tokenb {
    struct TOKENB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKENB>(arg0, 6, b"TOKENB", b"TokenB by SuiAI", b"TokenB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_03_10_33_12_A_creative_logo_designed_using_a_pill_shape_as_the_main_element_The_pill_is_stylized_with_vibrant_futuristic_colors_like_neon_blue_and_pink_an_7d059ab3e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKENB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

