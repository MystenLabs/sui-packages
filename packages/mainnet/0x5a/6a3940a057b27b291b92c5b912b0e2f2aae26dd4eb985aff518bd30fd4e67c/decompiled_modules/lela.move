module 0x5a6a3940a057b27b291b92c5b912b0e2f2aae26dd4eb985aff518bd30fd4e67c::lela {
    struct LELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LELA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LELA>(arg0, 6, b"LELA", b"LOLA", b"DAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiea26q5tuxvncf6afpxc6c6gyppyuxzq64ys74og2nxy56jvyjg3u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LELA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LELA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

