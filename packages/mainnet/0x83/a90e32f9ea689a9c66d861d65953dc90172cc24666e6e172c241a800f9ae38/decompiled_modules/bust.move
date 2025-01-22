module 0x83a90e32f9ea689a9c66d861d65953dc90172cc24666e6e172c241a800f9ae38::bust {
    struct BUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BUST>(arg0, 6, b"BUST", b"MemeBuster by SuiAI", b"Exposing crypto nonsense, one meme at a time. Think twice before aping in!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_0783_185e4c42d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

