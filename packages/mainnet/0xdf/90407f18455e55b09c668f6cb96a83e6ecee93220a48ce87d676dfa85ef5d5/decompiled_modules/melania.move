module 0xdf90407f18455e55b09c668f6cb96a83e6ecee93220a48ce87d676dfa85ef5d5::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIA>(arg0, 6, b"MELANIA", b"Melania Trump Sui", b"Melania Trump Sui $MELANIA is the epitome of elegance and strength on the Sui blockchain. More than just a memecoin, its a symbol of decentralized freedom, uniting a vibrant community of Web3 enthusiasts, degens, and patriots under one bold blue banner.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieaawsnrclanulvab7rtppuyfjeyejs32m6e7dogk2p5j3ceun3em")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MELANIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

