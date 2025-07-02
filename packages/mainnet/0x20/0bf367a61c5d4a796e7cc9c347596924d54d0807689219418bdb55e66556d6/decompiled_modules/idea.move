module 0x200bf367a61c5d4a796e7cc9c347596924d54d0807689219418bdb55e66556d6::idea {
    struct IDEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDEA>(arg0, 6, b"IDEA", b"Good Idea", b"What a good Idea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiffwab2uy4cjpkyg7ptt5kahosibyfj3ft7qyh3wrz2r7hfvjmifu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IDEA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

