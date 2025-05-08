module 0xbcc656aa098bfb04f10707d8df770b170910aac1312b8549078742f7ea39fc13::npt {
    struct NPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPT>(arg0, 6, b"NPT", b"NEPTUNE", b"Building tools that makes trading and Interactions on Sui easier| Utility driven Token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihljn6jstkyu66uoe4j5zau52uve72etoblcrhnp6hhxf5vd7rzyq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NPT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

