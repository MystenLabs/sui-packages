module 0xfe18477702ff489145c9ebf88635f766150a2dfcf74323ade972d413582881a::mermaid {
    struct MERMAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERMAID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERMAID>(arg0, 6, b"Mermaid", b"Laguna Mermaid", b"Laguna is a meme coin built on the high performance Sui Blockchain, embracing the enchanting and mysterious underwater world of mermaids.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidtset7qoduh576qg3ckjqtbxxiiiw2os2xep5cpgcfwrg47peh4i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERMAID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MERMAID>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

