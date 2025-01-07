module 0x88beec80e3d52b60d56b3c580c1b6fe3f28d42c20fea74361d273dd4d910b4a5::bpepe {
    struct BPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPEPE>(arg0, 6, b"BPEPE", b"BrettPepe", b"When Brett and Pepe combine on Sui! Website, Twitter followers. Unleashing the biggest community meme fest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_03_00_25_26_Create_an_8_bit_old_school_video_game_style_image_of_a_character_inspired_by_Pepe_from_official_pepe_com_The_character_should_have_a_pixelated_retr_68afb4e6c3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

