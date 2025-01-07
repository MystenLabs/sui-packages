module 0x1126b4027fe5078d25f800dfaa4424a32701fffbc9edfb55341e6f0f28524864::bbs {
    struct BBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBS>(arg0, 6, b"BBS", b"BABY-SHARK", b"Discover $BABYSHARK, the brand new meme token that is making waves in the crypto ocean!  Join us and swim with the biggest in this fun and promising adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_08_25_20_53_38_An_underwater_scene_featuring_a_blue_funny_degenerate_fish_character_with_a_gold_medal_similar_in_style_to_internet_memes_The_fish_is_sitting_in_f_a82944dbd8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

