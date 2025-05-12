module 0xfb7a937c2310adec22d5f4207cfa13f42227e56db4242c86462cbd897cac904d::satm {
    struct SATM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATM>(arg0, 6, b"SATM", b"SATOSHI MINING COIN", b"This is the official in-game currency and governance token of Satoshi Mining Project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidgb2fcfhzw7jj2pow64byc7w2nzry4driuudl2yx2xtsatd63nma")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SATM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

