module 0x78f120729985d329f6e49130d71fe2c7909dac9f3d3ecaf57bb120ff361d2adc::aisu {
    struct AISU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AISU>(arg0, 6, b"AISU", b"AI SUI (AISU)", x"537569277320666972737420414920746f6b656e2e0a0a4149535520697320616e2041492063686172616374657220616e6420616c6c20636f6e74656e742069732067656e657261746564206279207468652041492e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_30_12_33_55_A_profile_picture_for_the_AISU_character_The_background_features_the_fun_and_playful_AISU_character_with_bright_neon_colors_like_blues_and_purpl_904abefb3e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AISU>>(v1);
    }

    // decompiled from Move bytecode v6
}

