module 0xfb87f3c0bf1002554db87775acdd3edc3fc7c003c2dd0a4b7d86b382056a2ba4::ass {
    struct ASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASS>(arg0, 6, b"Ass", b"asc", b"asfdasf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiawy5kuv4awxvxyyqswyxpdemlz7m4jguyz2jpjf7yroqq6rsiyde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

