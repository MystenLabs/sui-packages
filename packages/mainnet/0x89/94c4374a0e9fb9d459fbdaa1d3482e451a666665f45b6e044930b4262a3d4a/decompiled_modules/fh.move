module 0x8994c4374a0e9fb9d459fbdaa1d3482e451a666665f45b6e044930b4262a3d4a::fh {
    struct FH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FH>(arg0, 6, b"FH", b"FHOP", b"FUCK HOPFUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_03_03_21_17_A_black_background_with_the_word_Hop_in_white_text_on_the_right_side_and_a_stylized_white_animal_figure_on_the_left_Place_a_prohibitive_symbol_a_caecaf3418.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FH>>(v1);
    }

    // decompiled from Move bytecode v6
}

