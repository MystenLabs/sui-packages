module 0x6cf555e8fc2c86e8fc6c05e61e0cf31b861d5e25de45bf2806c58726270be1b8::blilla {
    struct BLILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLILLA>(arg0, 6, b"BLILLA", b"BLUELILLA", b"bluelilla to conquer the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigj3nlzldbrunuqpwo5w3pkdaspbg3boh65cr2hfruhmwqvmtnmdq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLILLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

