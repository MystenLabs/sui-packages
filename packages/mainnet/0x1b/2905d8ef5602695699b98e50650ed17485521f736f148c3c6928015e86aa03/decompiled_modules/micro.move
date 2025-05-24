module 0x1b2905d8ef5602695699b98e50650ed17485521f736f148c3c6928015e86aa03::micro {
    struct MICRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICRO>(arg0, 6, b"MICRO", b"Micro Toad", b"Just a tiny, goofy and Micro frog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiar6fgtwryzvovvumagbqbwstyb4izqcg4olt6v52tbqie2a7wjou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MICRO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

