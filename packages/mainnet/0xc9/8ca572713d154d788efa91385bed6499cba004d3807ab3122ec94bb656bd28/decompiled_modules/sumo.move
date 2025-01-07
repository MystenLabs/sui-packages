module 0xc98ca572713d154d788efa91385bed6499cba004d3807ab3122ec94bb656bd28::sumo {
    struct SUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMO>(arg0, 6, b"SUMO", b"SUIMOON", b"Blast off to the Moon with SUI the symbol of rapid growth and limitless potential in the crypto world. Invest in a future that's already taking flight!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_11_00_07_02_A_super_cartoonish_image_of_a_character_happily_riding_on_a_rocket_labeled_SUI_flying_through_a_colorful_whimsical_space_The_character_should_hav_3ddf37bbf7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

