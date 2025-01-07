module 0x5cae82bc346036793e3fe70a8bec6f2d8b4675552ca132bc77b322fdf670e765::minar {
    struct MINAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINAR>(arg0, 6, b"MINAR", b"MINAR KIOFTE", b"minras kosfh dksdhsbdm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_13_19_06_07_A_comical_and_eye_catching_illustration_of_the_Future_Ape_character_a_blue_ape_from_the_future_with_a_cyberpunk_style_perfect_for_a_meme_The_ape_0441033068.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

