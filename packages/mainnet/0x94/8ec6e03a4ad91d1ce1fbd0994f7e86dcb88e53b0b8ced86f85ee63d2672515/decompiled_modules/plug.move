module 0x948ec6e03a4ad91d1ce1fbd0994f7e86dcb88e53b0b8ced86f85ee63d2672515::plug {
    struct PLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUG>(arg0, 6, b"PLUG", b"PLUG SUI", b"Plug is determined to soak everyone who believes in Suis future. Plug can feel the power of the entire crypto community. Just enjoy the water and dont assign too much meaning to it. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cd6d4070_84c2_4454_8b76_ab43959aa393_29696c200b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

