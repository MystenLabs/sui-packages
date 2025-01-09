module 0xb64914e7c94c777c40f5053718b3c09009a384be6af96ce13a867a27b755705d::slm {
    struct SLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLM>(arg0, 6, b"SLM", b"Sunny AI Agente Language Model", b"Sunny AI Agente Language Model.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_09_17_58_01_A_cute_anime_style_pixel_art_of_a_cat_named_Xiri_depicted_as_slightly_chubby_FAT_with_a_playful_and_happy_expression_The_cat_has_soft_fur_and_i_8593312c92.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

