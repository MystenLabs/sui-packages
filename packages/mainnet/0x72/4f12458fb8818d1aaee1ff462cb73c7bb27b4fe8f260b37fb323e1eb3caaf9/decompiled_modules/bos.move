module 0x724f12458fb8818d1aaee1ff462cb73c7bb27b4fe8f260b37fb323e1eb3caaf9::bos {
    struct BOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOS>(arg0, 6, b"BoS", b"Book of SUI", b"Book of SUI is a meme token inspired by the Sui blockchain, combining humor, community culture, and decentralized ideals. It aims to build a fun, engaging ecosystem while drawing from the lore and style of classic meme coins. Though rooted in entertainment, the token also serves as a gateway to the Sui community, inviting users to explore the broader possibilities of web3 through a lighthearted, narrative-driven approach.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihcl3drglvcpe42554ske2hxkml4a3xwq6sexcrrmxn53p6axbzne")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

