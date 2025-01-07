module 0x57c4e0990c71cb902a0e099e4dd8c31c1a23f26e4d4a3519fd35e04cb27a47ca::cider {
    struct CIDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIDER>(arg0, 6, b"CIDER", b"SUI CIDER", b"hmmm yo know", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_19_00_49_25_A_cute_cartoon_style_version_of_a_cider_juice_bottle_labeled_SUI_CIDER_but_with_a_worn_out_cracked_look_The_bottle_still_has_a_playful_and_exagg_8e9bdf53f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

