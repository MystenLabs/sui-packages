module 0x6dddc40bb6a96ccba86f187d62c3d6d157b9dce0e76b342ce1b6a19e64181172::cybrin {
    struct CYBRIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBRIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CYBRIN>(arg0, 6, b"CYBRIN", b"Cybrina", b"Cybrina is a cutting-edge digital influencer powered by neon circuits and boundless curiosity. With her sleek metallic charm and glowing blue accents, she embodies the perfect blend of futuristic aesthetics and relatable charisma.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2024_11_29_18_07_55_A_highly_pixelated_pixel_art_illustration_of_a_cute_and_sexy_doll_like_character_with_exaggerated_proportions_big_expressive_eyes_and_a_playful_pose_a49b21ae6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CYBRIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBRIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

