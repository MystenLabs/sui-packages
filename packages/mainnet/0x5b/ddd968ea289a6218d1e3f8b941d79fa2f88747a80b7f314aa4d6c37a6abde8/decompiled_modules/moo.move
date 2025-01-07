module 0x5bddd968ea289a6218d1e3f8b941d79fa2f88747a80b7f314aa4d6c37a6abde8::moo {
    struct MOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOO>(arg0, 6, b"MOO", b"MooDang", x"49662074686973206c6974746c652063757469652077696c6c206e6f742070756d70204920646f6e2774206b6e6f7720776861742077696c6c2e204c657427732073656e642069742e0a235452454e43484553464f5245564552", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/moo_dang_the_most_iconic_hippo_baby_v0_qkrj30b10kod1_4da024272c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

