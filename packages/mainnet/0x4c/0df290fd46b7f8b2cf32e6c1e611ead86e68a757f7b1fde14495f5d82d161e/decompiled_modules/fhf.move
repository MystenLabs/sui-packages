module 0x4c0df290fd46b7f8b2cf32e6c1e611ead86e68a757f7b1fde14495f5d82d161e::fhf {
    struct FHF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHF>(arg0, 6, b"FHF", b"Fuck HFUN", b"FUCK HFUN!! NO MORE WAITING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_03_03_21_17_A_black_background_with_the_word_Hop_in_white_text_on_the_right_side_and_a_stylized_white_animal_figure_on_the_left_Place_a_prohibitive_symbol_a_0a8d252228.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FHF>>(v1);
    }

    // decompiled from Move bytecode v6
}

