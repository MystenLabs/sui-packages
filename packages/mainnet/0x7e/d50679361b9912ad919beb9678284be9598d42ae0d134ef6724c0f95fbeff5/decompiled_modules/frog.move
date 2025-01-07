module 0x7ed50679361b9912ad919beb9678284be9598d42ae0d134ef6724c0f95fbeff5::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 6, b"FROG", b"FrogChill", b"FrogChill is a unique digital token representing a laid-back cartoon frog with a cigarette, embodying a carefree and humorous attitude towards life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_15_00_12_13_A_cartoon_style_frog_with_a_cigarette_in_its_mouth_sitting_casually_The_frog_has_a_playful_expression_with_bright_green_skin_and_large_eyes_The_ci_f72b0e6077.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

