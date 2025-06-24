module 0x1118d2f18544c50e101e3c2dc2923e6a9a6f10c28fa807e638ba5c57a0f19c37::ttt {
    struct TTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTT>(arg0, 6, b"TTT", b"tets2", b"second tets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifmbdeyntotrzlxnouvvm73hcn5fp2pnmfobwu4aarp4prk3ruvpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

