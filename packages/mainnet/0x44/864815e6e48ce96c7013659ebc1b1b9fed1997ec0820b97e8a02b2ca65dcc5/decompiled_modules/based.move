module 0x44864815e6e48ce96c7013659ebc1b1b9fed1997ec0820b97e8a02b2ca65dcc5::based {
    struct BASED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASED>(arg0, 6, b"BASED", b"BASED ON SUI", b"Time to make sui based", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_08_12_00_56_A_lively_outdoor_scene_with_two_men_on_a_stage_The_stage_has_a_banner_in_red_white_and_blue_with_stars_resembling_an_American_patriotic_theme_In_9cbfe8ea77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASED>>(v1);
    }

    // decompiled from Move bytecode v6
}

