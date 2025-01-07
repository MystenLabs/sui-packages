module 0x1238bfcdbc4658926db6e1e16afb2d0c97f6c5bb51a32c68eebf0902c8705f56::suisad {
    struct SUISAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISAD>(arg0, 6, b"SuiSad", b"SUISAD", b"i am very sad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_07_22_59_43_A_digital_themed_image_representing_a_meme_cryptocurrency_now_with_a_sad_dejected_appearance_The_coin_in_the_center_should_have_a_slightly_drooping_77f0370383.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

