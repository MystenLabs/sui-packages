module 0x2ecf7b2b7411d3f109203bbb950e3454556dff3c491bec56c5cf20d64005e9a1::slg {
    struct SLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLG>(arg0, 6, b"SLG", b"Solo Leveling", b"Solo Leveling Wins First-Ever Best Anime Series Award at Astra Awards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihvweeti56yb4gujmbp4ug4w2elxmchdfvbhfgsjzhp4qlyuvhmqi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SLG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

