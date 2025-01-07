module 0x546a6f89b04afe0b552f1a9415c25cc2437db988622b17344c977a9ca85a1b28::baa {
    struct BAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAA>(arg0, 9, b"BAA", b"baa sheep", b"The first sheep to baaaaaa into Sui. Inspired by aaa cat the best cat on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FDALLA_E_2024_09_23_11_35_27_A_meme_like_image_with_a_cartoonish_sheep_on_the_left_side_yelling_with_its_mouth_wide_open_A_speech_bubble_says_Can_t_stop_won_t_stop_thinking_ab_630b09e05f.webp&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BAA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

