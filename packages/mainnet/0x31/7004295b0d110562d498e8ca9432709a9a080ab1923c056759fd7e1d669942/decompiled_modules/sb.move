module 0x317004295b0d110562d498e8ca9432709a9a080ab1923c056759fd7e1d669942::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB>(arg0, 6, b"SB", b"SUIBITCOIN", b"SUI WILL REPLACE BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_04_04_07_25_An_enhanced_version_of_the_previous_image_with_the_Sui_logo_inside_the_large_S_now_filled_with_a_sketch_like_pattern_of_the_word_Sui_in_a_repeatin_6d155dd4d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SB>>(v1);
    }

    // decompiled from Move bytecode v6
}

