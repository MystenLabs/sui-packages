module 0xdf9935f9fe30a87fe65aac4d982868fc5c129e658847e7680bf1474b2727ea7a::puppy {
    struct PUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPPY>(arg0, 6, b"PUPPY", b"SUIPUPPY", b"sui network dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigwwerircmompb6va2dmukhb44amork7p5dad5jb6hxhcrext7eji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUPPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

