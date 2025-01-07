module 0x43822f0bb409a73ef8e004e6c2e1acfcd96f1ff2d76e8b32575da82869ed8e18::fhf {
    struct FHF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHF>(arg0, 6, b"FHF", b"Fuck-HFun", x"4e6f206d6f72652077616974696e672121204675636b2d4846756e206973206c6976652e0a0a5468697320636f696e20697320666f7220746865206f6e6527732077686f206973207374696c6c2077616974696e6720666f7220686f7066756e20746f206c61756e63682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_03_03_21_17_A_black_background_with_the_word_Hop_in_white_text_on_the_right_side_and_a_stylized_white_animal_figure_on_the_left_Place_a_prohibitive_symbol_a_615f3b3f27.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FHF>>(v1);
    }

    // decompiled from Move bytecode v6
}

