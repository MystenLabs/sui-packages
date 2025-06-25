module 0x7addc3329aee28e552bfd661a5d534cc61b90cc76f54587bfcd3097dc95e109f::bfs {
    struct BFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFS>(arg0, 6, b"BFS", b"BLUE FLAME SUI", b"Blue Flame Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiacu3fd7oxwmcv6z7tto7q4nek5pzdfohuvdxdxe3cf4pfdyklole")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BFS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

