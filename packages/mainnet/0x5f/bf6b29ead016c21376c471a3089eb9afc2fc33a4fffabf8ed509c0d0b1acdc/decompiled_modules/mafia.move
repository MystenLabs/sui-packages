module 0x5fbf6b29ead016c21376c471a3089eb9afc2fc33a4fffabf8ed509c0d0b1acdc::mafia {
    struct MAFIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAFIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAFIA>(arg0, 6, b"Mafia", b"Sui Mafia", b"we are sui mafia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_13_19_14_40_A_Twitter_background_image_featuring_the_Future_Ape_character_a_blue_ape_from_the_future_with_a_cyberpunk_aesthetic_The_ape_has_electric_blue_skin_5b9a3247df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAFIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAFIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

