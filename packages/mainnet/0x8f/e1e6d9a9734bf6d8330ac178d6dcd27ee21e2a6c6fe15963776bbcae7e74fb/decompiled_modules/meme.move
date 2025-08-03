module 0x8fe1e6d9a9734bf6d8330ac178d6dcd27ee21e2a6c6fe15963776bbcae7e74fb::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 6, b"MEME", b"MemeLand", b"From the team that brought you 9GAG comes Memeland, a web3-focused venture studio. We are building and investing in social products for community, with community. We are connecting creators and communities together through creativity, MEME, and NFTs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicg7mdr56fta4bl5ouzu6jkjqe3mqvujatycur57otbbutldll6w4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

