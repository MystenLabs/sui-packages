module 0xc0d2f3c0d9a769d8eb3356c8eab73a9f4bc69460a374b39890d22ac895306a5b::sumon {
    struct SUMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMON>(arg0, 6, b"SUMON", b"Sumon On Sui", b"Sumon is the most unique Pokemon in Sui, with its running speed it can surpass all other Pokemon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihhu7k7sdc5e2o5qtaw7d7lbbsbwgaruad4vfkfj5npr4ld2nfvyi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

