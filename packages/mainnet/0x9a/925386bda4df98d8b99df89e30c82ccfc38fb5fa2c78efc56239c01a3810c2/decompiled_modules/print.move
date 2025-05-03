module 0x9a925386bda4df98d8b99df89e30c82ccfc38fb5fa2c78efc56239c01a3810c2::print {
    struct PRINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRINT>(arg0, 6, b"PRINT", b"Print-a-chu", b"PRINT-A-CHU! I CHOSE YOU!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_03_24_21_56_34_A_simple_and_bold_illustration_in_the_style_of_a_sermon_thumbnail_depicting_two_figures_facing_each_other_one_handing_a_heart_shape_to_the_other_sym_ee9bad2f8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

