module 0xafeb5901eb2aa2d61b4b60fa7034952c32025b121367dd0839375e199853f8a5::frogs {
    struct FROGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGS>(arg0, 6, b"FROGS", b"FrogChill", b"FrogChill is a unique digital token representing a laid-back cartoon frog with a cigarette, embodying a carefree and humorous attitude towards life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLE_2024_10_15_00_12_13_A_cartoon_style_frog_with_a_cigarette_in_its_mouth_sitting_casually_The_frog_has_a_playful_expression_with_bright_green_skin_and_large_eyes_The_ci_7d4774323d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

