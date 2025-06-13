module 0x7b8b4d9d08d0439b83d094c440637f148710de1ebee3a3a4a8f9671db9eb4d32::www {
    struct WWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWW>(arg0, 6, b"WWW", b"Worldwide Walrus Coin", b"$WWW IS A MEME COIN DESIGNED TO BRING MORE ATTENTION TO WALRUS PROTOCOL BY SHOWCASING ITS NFT COMPATIBILITY AND REAL-WORLD USE CASES. MAKING DECENTRALIZED STORAGE FUN, VIRAL, AND ACCESSIBLE TO ALL.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigg2e27yn4gitmjgcebxoy3fu47f6cvpzf3rqmky2kr4lfvy7f2mm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WWW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

