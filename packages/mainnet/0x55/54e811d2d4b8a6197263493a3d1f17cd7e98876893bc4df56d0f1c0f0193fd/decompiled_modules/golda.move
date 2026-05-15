module 0x5554e811d2d4b8a6197263493a3d1f17cd7e98876893bc4df56d0f1c0f0193fd::golda {
    struct GOLDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDA>(arg0, 6, b"GOLDA", b"GOLDA - new age of RWA on SUI", x"474f4c4441202d207265616c2061737365742c206261636b6564206279207075726520476f6c64203939390a427579202620486f6c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidcclwaav3mumzwexaurss35lmyq5mlqf2hce7eowrva2gbsdsydy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOLDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

