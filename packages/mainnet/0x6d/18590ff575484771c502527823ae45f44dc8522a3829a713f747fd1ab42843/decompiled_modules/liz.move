module 0x6d18590ff575484771c502527823ae45f44dc8522a3829a713f747fd1ab42843::liz {
    struct LIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIZ>(arg0, 6, b"LIZ", b"Lizzard", b"Discover a smarter way to access real-time cryptocurrency data with our AI-powered assistant. Get instant insights on token prices, market trends, and more, all in one place!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafybeihpxyikpgww2hillufxc6rg2kbmnn3ahsemesgurn4mt3jzqy5hzm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

