module 0xf0bc5f94367b5c15ec29c399fd9a023b79a67f17e02794db7059432636b565e7::ime {
    struct IME has drop {
        dummy_field: bool,
    }

    fun init(arg0: IME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IME>(arg0, 6, b"IME", b"IME", b"IME ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.artistfirst.in/uploads/1737714071132-Anime.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

