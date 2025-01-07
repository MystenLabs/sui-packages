module 0x772424c666e3ac206ca0df1d9d04b191dc140f1cd8a68ae846d100bc785cfa53::ss {
    struct SS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SS>(arg0, 6, b"SS", b"SUITAMA", b"Suitama is a meme token inspired by our love for popular culture and the crypto community. Designed to bring fun and humor into the crypto world, Suitama aims to create an enjoyable investment experience for everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_14_23_06_04_Create_a_logo_that_combines_the_character_Saitama_from_the_first_image_bald_wearing_a_yellow_suit_red_gloves_and_white_cape_with_the_clean_mini_c41e54c046.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SS>>(v1);
    }

    // decompiled from Move bytecode v6
}

