module 0xbdf738110ad9e4f75c64eec8c2fa1828b8b7ce27c5a457c0e31f3a59a59b4843::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 6, b"AQUA", b"AQUA CAT", b"\"Caught in the rain, but making it reign on the SUI Network!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicd6z457t4dkmmizmldth6knnegpbvuwkcgn6ynbcxhfz33mnzkbi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AQUA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

