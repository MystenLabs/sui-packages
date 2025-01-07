module 0x35799eb2662b489f071d2cc252de3f99a623e1767475c517d9eb8fda212f8a15::peek {
    struct PEEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEK>(arg0, 6, b"Peek", b"Peek Cat", b"Peeks Cat been lurking in the shadows, watching every move with sharp instincts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Peek_4a9b5c75cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

