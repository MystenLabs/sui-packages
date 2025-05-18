module 0xfea15247d3fbbff3463dec1b932ccb6c7d37dc46d2d196848cb2b3696dde23ce::rudo {
    struct RUDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUDO>(arg0, 6, b"RUDO", b"Sui Rudo", b"$RUDO has magical powers since birth, his natural habitat may be in the sky but he also has abilities Rudo has magical powers since birth, his natural habitat may be in the sky but he also has abilities in the ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiep3hgbqbllpgcbuaxrbsv6x52zep4ec3sblgdvdxavmxp63h6cu4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RUDO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

