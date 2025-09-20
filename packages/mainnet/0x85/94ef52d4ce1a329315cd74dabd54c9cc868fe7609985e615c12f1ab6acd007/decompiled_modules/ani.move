module 0x8594ef52d4ce1a329315cd74dabd54c9cc868fe7609985e615c12f1ab6acd007::ani {
    struct ANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANI>(arg0, 6, b"ANI", b"Anime", b"Anime is an anime-themed entertainment & meme cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif4sl77tmpijm3lnnu526hflgwvlcnyugsyhxhkwzsnoztcdmknqe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

