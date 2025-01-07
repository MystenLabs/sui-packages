module 0xf79adaa8576322929fa2861815dad4c5bafcc3cf4826542f7ee84f19c33e784b::fff {
    struct FFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFF>(arg0, 6, b"FFF", b"FLUFFO", b"Meme Universe is focused on creating a variety of interconnected meme coins, where each coin strengthens and supports the others. Backed by the platform itself, this ecosystem enables the coins to benefit from each others success, forming a unified and self-sustaining network, Unlike random, riskier meme coins, Meme Universe provides a safer, more reliable alternative for users.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2997_fd8d90a863.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

