module 0x40c8779684a687a016ca41f58ecac194971a27454b6752c467099d197a50c878::dolw {
    struct DOLW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLW>(arg0, 6, b"DOLW", b"DolphinWave", b"DolphinWave is a playful and nostalgic token inspired by classic 8-bit pixel art. Featuring a pixelated dolphin swimming in a calm, light blue ocean, this token represents smooth, effortless progress in the market, just like a dolphin gliding through water. DolphinWave embodies the fusion of retro gaming culture with modern blockchain technology, making it the perfect token for those who love both creativity and digital finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_23_14_18_22_A_simple_8_bit_pixel_art_image_featuring_a_dolphin_in_a_light_blue_ocean_background_The_dolphin_is_designed_in_classic_retro_pixel_style_with_minima_f02c0f8987.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLW>>(v1);
    }

    // decompiled from Move bytecode v6
}

