module 0x975b9c5eb3f06ff3a62b1e99b967d63ef388105d2884bf3afba7239683e1e999::yam {
    struct YAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAM>(arg0, 6, b"YAM", b"Yet Another Meme", b"Yet Another Meme (YAM) is a token inspired by the humor and simplicity of internet memes. Created on the SUI network, YAM aims to capture fun and community-driven value in the crypto ecosystem, offering a fresh and entertaining addition to the blockchain world. Twitter, website, and Telegram channels are TBA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_10_26_21_27_55_An_image_representing_a_playful_humorous_cryptocurrency_token_named_Yet_Another_Meme_YAM_in_a_meme_inspired_style_The_design_includes_bright_co_a8f76f83d0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

