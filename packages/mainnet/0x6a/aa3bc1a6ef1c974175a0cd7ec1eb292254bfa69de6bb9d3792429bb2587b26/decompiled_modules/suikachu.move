module 0x6aaa3bc1a6ef1c974175a0cd7ec1eb292254bfa69de6bb9d3792429bb2587b26::suikachu {
    struct SUIKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKACHU>(arg0, 6, b"SUIKACHU", b"Suikachu pokemon", b"Suikachu is the first meme pikachu on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeideetvqqo22ievw3rfdrguillebcjapmk2kr6hqbhwx2zyn2hh6yi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIKACHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

