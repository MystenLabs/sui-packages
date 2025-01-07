module 0xf3334f0844ece6df3a7c24252acf406cf57fbeb5616efca06c68d8c7124cdf2::mist {
    struct MIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIST>(arg0, 6, b"MIST", b"MIST", b"MIST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmXfKoD1f6dLvD3iBJ4v5TnaB75bnDiuMutDnQyknmr6zE")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<MIST>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<MIST>(4307408858504540306, v0, v1, 0x1::string::utf8(b"no twitter"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

