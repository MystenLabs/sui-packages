module 0xe79b8535682afd165c441394c460887bc557b40666af5047058ef9f01d5c0a7a::loremipsum {
    struct LOREMIPSUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOREMIPSUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOREMIPSUM>(arg0, 6, b"LOREMIPSUM", b"LOREM", b"LOREMIPSUM DOLOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigpxdxrkxhbndrzigzoprqkmk2qhswvqyckicqrzzaq46n2cxu7cu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOREMIPSUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOREMIPSUM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

