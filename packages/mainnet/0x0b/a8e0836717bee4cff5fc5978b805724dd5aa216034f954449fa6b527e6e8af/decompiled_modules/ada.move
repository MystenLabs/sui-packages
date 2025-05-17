module 0xba8e0836717bee4cff5fc5978b805724dd5aa216034f954449fa6b527e6e8af::ada {
    struct ADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADA>(arg0, 6, b"Ada", b"asda", b"adfsa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiawy5kuv4awxvxyyqswyxpdemlz7m4jguyz2jpjf7yroqq6rsiyde")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

