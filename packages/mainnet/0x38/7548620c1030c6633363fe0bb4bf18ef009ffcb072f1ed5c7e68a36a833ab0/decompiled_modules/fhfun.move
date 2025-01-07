module 0x387548620c1030c6633363fe0bb4bf18ef009ffcb072f1ed5c7e68a36a833ab0::fhfun {
    struct FHFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHFUN>(arg0, 6, b"FHFUN", b"Fuck HFUN", x"4675636b204846554e2121210a0a4e4f204d4f52452044454c4159532e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_03_03_21_17_A_black_background_with_the_word_Hop_in_white_text_on_the_right_side_and_a_stylized_white_animal_figure_on_the_left_Place_a_prohibitive_symbol_a_017cd99a9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FHFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

