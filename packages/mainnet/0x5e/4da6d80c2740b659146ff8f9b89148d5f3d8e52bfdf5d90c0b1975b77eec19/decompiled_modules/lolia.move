module 0x5e4da6d80c2740b659146ff8f9b89148d5f3d8e52bfdf5d90c0b1975b77eec19::lolia {
    struct LOLIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOLIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOLIA>(arg0, 6, b"LOLIA", b"Lolia On Sui", b"She memes. She learns. That`s it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeienjelff7covomns445vdc47rjdqlse6atdj4eeqntp2s3npksbk4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOLIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOLIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

