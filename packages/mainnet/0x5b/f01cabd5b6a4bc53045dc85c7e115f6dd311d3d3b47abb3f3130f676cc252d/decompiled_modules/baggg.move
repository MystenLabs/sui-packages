module 0x5bf01cabd5b6a4bc53045dc85c7e115f6dd311d3d3b47abb3f3130f676cc252d::baggg {
    struct BAGGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAGGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAGGG>(arg0, 6, b"BAGGG", b"agggg", b"aaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifycc3mp5ox5e5qnqd52ns2aalqafzaq5jjkczwtijhkqotkkmhca")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAGGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAGGG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

