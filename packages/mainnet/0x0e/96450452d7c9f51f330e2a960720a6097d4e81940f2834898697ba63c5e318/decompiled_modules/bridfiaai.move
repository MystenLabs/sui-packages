module 0xe96450452d7c9f51f330e2a960720a6097d4e81940f2834898697ba63c5e318::bridfiaai {
    struct BRIDFIAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIDFIAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIDFIAAI>(arg0, 6, b"BridfiaAI", b"Bridfia AI", b"AI agents bred for market warfare | Real-time intel, on-chain analytics, predictive fire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicrgwtnkrxgukipufsygdh6r6vkg5ljdkgyfg5myg3cijbtsilngu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIDFIAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRIDFIAAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

