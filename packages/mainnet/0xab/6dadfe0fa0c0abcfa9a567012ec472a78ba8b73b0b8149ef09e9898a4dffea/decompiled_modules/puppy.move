module 0xab6dadfe0fa0c0abcfa9a567012ec472a78ba8b73b0b8149ef09e9898a4dffea::puppy {
    struct PUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPPY>(arg0, 6, b"PUPPY", b"PUPPYSUI", b"NEW SUI MASCOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigwwerircmompb6va2dmukhb44amork7p5dad5jb6hxhcrext7eji")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUPPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

