module 0xc8f0802a94006143ed7bfc60bf3cef61b59dbaa53a6492694f66b3e08ab4e829::clop {
    struct CLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOP>(arg0, 6, b"CLOP", b"EterClop", b"CLOP the memecoin of the multiverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif5miqsxcg75nqthxnscek33rabopwjh6wlu72wqe5huqanw67t4a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

