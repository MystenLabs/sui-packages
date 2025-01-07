module 0xfe6e7b828ba8eddf021deda072ab226248ee69e9fb79d21fb47c8c29ac43f077::subli {
    struct SUBLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBLI>(arg0, 6, b"Subli", b"Suica Bliat", b"Suica suica suica bliat, nahui suica bliat?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_10_15_44_26_A_pixel_art_scene_focused_on_a_single_character_resembling_a_terrorist_from_classic_tactical_shooter_games_The_character_should_wear_a_bandana_or_mas_c902fb5f8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

