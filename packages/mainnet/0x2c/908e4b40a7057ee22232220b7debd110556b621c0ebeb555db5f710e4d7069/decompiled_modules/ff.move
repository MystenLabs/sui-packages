module 0x2c908e4b40a7057ee22232220b7debd110556b621c0ebeb555db5f710e4d7069::ff {
    struct FF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FF>(arg0, 6, b"FF", b"Fuck-Fun", x"4e6f206d6f72652077616974696e672121204675636b2d46756e20776520617265206c697665202121210a0a5468697320636f696e206372656174656420666f7220746865206f6e6527732077686f207374696c6c2077616974696e6720666f7220686f7066756e20746f206c61756e6368", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_03_03_21_17_A_black_background_with_the_word_Hop_in_white_text_on_the_right_side_and_a_stylized_white_animal_figure_on_the_left_Place_a_prohibitive_symbol_a_2b723d4703.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FF>>(v1);
    }

    // decompiled from Move bytecode v6
}

