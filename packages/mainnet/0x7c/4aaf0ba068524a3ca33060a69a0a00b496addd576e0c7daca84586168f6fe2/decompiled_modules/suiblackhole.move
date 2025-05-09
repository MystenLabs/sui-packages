module 0x7c4aaf0ba068524a3ca33060a69a0a00b496addd576e0c7daca84586168f6fe2::suiblackhole {
    struct SUIBLACKHOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBLACKHOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBLACKHOLE>(arg0, 6, b"SUIBLACKHOLE", b"BLACKMOONHOLE", b"Inspired by the mysterious force of real black holes, $SUIBLACKHOLE represents a powerful blend of meme culture, community energy, and unstoppable hype. This is not just a token it's a gravitational event.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidxx3fjlr6lppj7nvlexcfzndgd5czktxeosbmtjjaomruhnhitz4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBLACKHOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBLACKHOLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

