module 0x4b58c7e2951932fa0371734811706cddb803b8ce211bc1050de7319c38f40b10::sm {
    struct SM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SM>(arg0, 6, b"SM", b"SuiMeme", b"SuiMeme\" is a fun and innovative meme cryptocurrency designed to attract the meme and digital currency community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_05_22_25_28_Design_a_creative_logo_for_a_cryptocurrency_named_Sui_Meme_The_logo_should_be_fun_and_engaging_with_a_meme_like_style_Include_the_name_Sui_Meme_i_e6e6143166.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SM>>(v1);
    }

    // decompiled from Move bytecode v6
}

