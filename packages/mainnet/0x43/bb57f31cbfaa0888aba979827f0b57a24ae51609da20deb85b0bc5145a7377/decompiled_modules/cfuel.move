module 0x43bb57f31cbfaa0888aba979827f0b57a24ae51609da20deb85b0bc5145a7377::cfuel {
    struct CFUEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFUEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFUEL>(arg0, 6, b"CFUEL", b"Cfuel sloth sam", b"Ch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiblxuv7iiygdoapjjke2aastjvub2n77prq5lxabsdjjljsxchib4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFUEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CFUEL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

