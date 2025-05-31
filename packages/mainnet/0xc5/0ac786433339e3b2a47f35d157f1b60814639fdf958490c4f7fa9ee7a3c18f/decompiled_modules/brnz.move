module 0xc50ac786433339e3b2a47f35d157f1b60814639fdf958490c4f7fa9ee7a3c18f::brnz {
    struct BRNZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRNZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRNZ>(arg0, 6, b"BRNZ", b"Brainfuzz", b"The worlds first AI directed memecoin. No roadmap. No promises. Just BRNZ, Pure chaos.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif3y23dqcpch7fcl4liwrb33z5ycyv2zhmveiiheijunua6jytvh4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRNZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BRNZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

