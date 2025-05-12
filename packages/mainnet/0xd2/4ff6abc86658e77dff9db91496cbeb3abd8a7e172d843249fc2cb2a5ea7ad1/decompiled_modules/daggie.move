module 0xd24ff6abc86658e77dff9db91496cbeb3abd8a7e172d843249fc2cb2a5ea7ad1::daggie {
    struct DAGGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAGGIE>(arg0, 6, b"DAGGIE", b"DAGGIE IN SUI", x"24444147474945202d20546865206c6f76656c792070757070792077686f20616c776179732077616e74656420746f20706c61792e20486520697320636f6d696e6720696e20245355492e0a436f6d6520616e6420657870657269656e6365206a6f796f757320616e64206c6f76652074696d65207769746820244441474749452e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiccmbnx325yg2lxbbm6afn57mysuvglmztegy5pucnwm3ykcjqoxy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAGGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAGGIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

