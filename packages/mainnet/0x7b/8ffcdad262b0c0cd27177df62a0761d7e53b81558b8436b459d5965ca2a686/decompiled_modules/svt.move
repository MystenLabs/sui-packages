module 0x7b8ffcdad262b0c0cd27177df62a0761d7e53b81558b8436b459d5965ca2a686::svt {
    struct SVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SVT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SVT>(arg0, 6, b"SVT", b"SuiVote", b"Suivote is a leading cryptocurrency aggregation platform, spotlighting early stage tokens, NFTs, and meme coins with high potential.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid4bqcsq3hn5k7dlshl7bse66s6h674idltqwim7hrvmnjkd2cdtu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SVT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SVT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

