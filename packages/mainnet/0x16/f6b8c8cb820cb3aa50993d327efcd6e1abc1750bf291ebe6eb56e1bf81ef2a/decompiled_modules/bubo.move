module 0x16f6b8c8cb820cb3aa50993d327efcd6e1abc1750bf291ebe6eb56e1bf81ef2a::bubo {
    struct BUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBO>(arg0, 6, b"BUBO", b"Bubbo", b"Visualize your crypto moves", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiey3tvahv2zdei34b4li3m3injq64ouh44e753guiibruqnswljzi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUBO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

