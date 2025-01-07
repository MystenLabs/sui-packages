module 0x38db6193cff5ce64e59255bfade3934067921774ae162b3c066acedcf943924d::plu {
    struct PLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLU>(arg0, 6, b"Plu", b"Chriplu", b"A meme revolution has begun, and Chriplu is leading the charge. The world is about to see the magic of memes like never before!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_26_19_39_53_A_cute_cartoon_style_round_bird_character_exactly_like_the_original_but_in_Sui_blue_color_The_character_should_have_large_shiny_eyes_a_small_beak_549931819d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

