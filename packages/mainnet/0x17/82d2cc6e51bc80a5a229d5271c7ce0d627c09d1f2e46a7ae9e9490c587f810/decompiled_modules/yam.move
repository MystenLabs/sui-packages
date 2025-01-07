module 0x1782d2cc6e51bc80a5a229d5271c7ce0d627c09d1f2e46a7ae9e9490c587f810::yam {
    struct YAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAM>(arg0, 6, b"YAM", b"YAMYAM", b"yamyam sleep like a bunny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_20_12_36_31_A_cartoon_style_blue_rabbit_with_a_tired_expression_yawning_with_its_eyes_half_closed_The_rabbit_has_soft_round_features_and_exaggerated_large_ears_bb30928686.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

