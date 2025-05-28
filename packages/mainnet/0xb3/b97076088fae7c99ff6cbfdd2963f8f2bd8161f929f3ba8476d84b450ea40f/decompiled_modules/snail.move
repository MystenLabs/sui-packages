module 0xb3b97076088fae7c99ff6cbfdd2963f8f2bd8161f929f3ba8476d84b450ea40f::snail {
    struct SNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAIL>(arg0, 6, b"Snail", b"snail world", b"Animals Snail move by crawling using their muscular foot, while secreting mucus to aid movement across various surfaces.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib777kaumhscd6qz46bppx5hgyrefk3leaizwxlqlzhlcsoscz77q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNAIL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

