module 0xa9c27201730c5a17c628e7b5647ee12174e6df3d86a772a2d30ea4a5bc60b22c::baa {
    struct BAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAA>(arg0, 6, b"BAA", b"baa sheep", b"The first sheep to baaaaaa into Sui. Inspired by aaa cat the best cat on Sui. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_23_11_35_27_A_meme_like_image_with_a_cartoonish_sheep_on_the_left_side_yelling_with_its_mouth_wide_open_A_speech_bubble_says_Can_t_stop_won_t_stop_thinking_ab_630b09e05f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

