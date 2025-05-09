module 0xce58d0c8babb16c7aceefcba1f7d8a91ff7193435e0c2690b93505e79a7df494::one {
    struct ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE>(arg0, 6, b"ONE", b"Just Buy $1 and Worth of $100", b"just buy one dollar and worth of $100 dollar if you holding", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibi4mntcd6a2ptjfj5eoqaq2sxt5mqrxcxnlrewfnzq6p2ygahk34")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ONE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

