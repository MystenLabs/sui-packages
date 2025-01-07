module 0x5be74a11821c3d4f842373c6cef860d404226c946716172624044c9da38600e4::pepspc {
    struct PEPSPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPSPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPSPC>(arg0, 6, b"PEPSPC", b"PEPE SPACE SUI", b"Pepe Space Sui is a project starring a blue space frog who travels the universe in search of epic adventures. With a unique design and a futuristic theme, this project combines creativity, humor and galactic exploration. Perfect for those looking for something innovative and fun in the cosmos. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_01_09_24_35_A_space_themed_art_piece_featuring_a_Pepe_the_Frog_inspired_character_with_a_blue_face_and_minimalist_design_The_character_s_eyes_prominently_display_2043267a9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPSPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPSPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

