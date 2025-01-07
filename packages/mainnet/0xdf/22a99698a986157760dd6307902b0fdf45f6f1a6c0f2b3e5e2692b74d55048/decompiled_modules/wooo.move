module 0xdf22a99698a986157760dd6307902b0fdf45f6f1a6c0f2b3e5e2692b74d55048::wooo {
    struct WOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOO>(arg0, 6, b"WOOO", b"$WOOO", b"The Stylin', profilin', limousine riding, jet flying, kiss-stealing, wheelin' n' dealin' son of a gun! If you don't like it, learn to *love* it! WOOO!!! WE WILL DO NUMBERS LIKE NEVER BEFORE.COMMUNITY WILL BUILD WOOO MILLIONAIRES.WELCOME.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6315_8071a497bf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

