module 0xf4e545b2730406286d46a871e6149c45a49b5c6c531bf4c9f71655a08dd1c5d3::gold {
    struct GOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLD>(arg0, 6, b"GOLD", b"SUI GOLD", b"fdsjkfds sdfkdsfj dsjflds fjdsf jdsjf  dskf sdkfsdmfk sdkfl sdf sd fsd f sdf sdd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_13_19_06_23_A_professional_digital_illustration_of_the_Future_Ape_character_a_blue_ape_from_the_future_with_a_high_tech_cyberpunk_aesthetic_suitable_for_a_web_d280d0918c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

