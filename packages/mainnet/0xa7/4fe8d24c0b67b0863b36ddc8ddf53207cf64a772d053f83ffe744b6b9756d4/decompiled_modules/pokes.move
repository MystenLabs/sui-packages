module 0xa74fe8d24c0b67b0863b36ddc8ddf53207cf64a772d053f83ffe744b6b9756d4::pokes {
    struct POKES has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKES>(arg0, 6, b"POKES", b"PokesOnSui", b"The first Pokemon comic on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidyqr33muzjztsdzoy5cpleihwe4zeoy67inzeczw6rttv6mvbify")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

