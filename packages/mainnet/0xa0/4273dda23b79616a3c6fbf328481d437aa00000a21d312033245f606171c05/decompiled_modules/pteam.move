module 0xa04273dda23b79616a3c6fbf328481d437aa00000a21d312033245f606171c05::pteam {
    struct PTEAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTEAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTEAM>(arg0, 6, b"PTEAM", b"Poke Team", b"Poke Team Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidexjx6oxrt6g6kx67ppc2ddyduqhb7ewjwj77etefptyam7ilgzq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTEAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PTEAM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

