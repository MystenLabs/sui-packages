module 0xdc32edcdbb5589fe73ac949a089d755622770228d1391aa403f9255847c41ca9::shaba {
    struct SHABA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHABA>(arg0, 6, b"Shaba", b"Me at the Zoo", b"In 2005, YouTube founder Jawed Karim shot YouTube's first video \"Me at the zoo\" at the San Diego Zoo. According to research, the elephant in the video is called Shaba, and he is 44 years old this year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zi_K_Th_WX_0_BIF_Xp_5c65ce8a62.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHABA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHABA>>(v1);
    }

    // decompiled from Move bytecode v6
}

