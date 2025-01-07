module 0x5646b3c9c1e13e1e4a6fc7bc263688a2583d51a38f5c2568e61bb6df6dd035f9::chriplu {
    struct CHRIPLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRIPLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHRIPLU>(arg0, 6, b"Chriplu", b"chriplu", b"A meme revolution has begun, and Chriplu is leading the charge. The world is about to see the magic of memes like never before!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_26_19_39_53_A_cute_cartoon_style_round_bird_character_exactly_like_the_original_but_in_Sui_blue_color_The_character_should_have_large_shiny_eyes_a_small_beak_549931819d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRIPLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHRIPLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

