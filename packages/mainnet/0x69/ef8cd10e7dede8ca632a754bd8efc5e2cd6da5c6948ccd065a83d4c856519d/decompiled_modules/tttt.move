module 0x69ef8cd10e7dede8ca632a754bd8efc5e2cd6da5c6948ccd065a83d4c856519d::tttt {
    struct TTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTTT>(arg0, 6, b"TTTT", b"tets3", b"last tets of the night", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifmbdeyntotrzlxnouvvm73hcn5fp2pnmfobwu4aarp4prk3ruvpu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

