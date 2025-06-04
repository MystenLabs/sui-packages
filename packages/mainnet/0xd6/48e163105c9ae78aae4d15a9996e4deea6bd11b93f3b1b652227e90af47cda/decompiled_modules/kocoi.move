module 0xd648e163105c9ae78aae4d15a9996e4deea6bd11b93f3b1b652227e90af47cda::kocoi {
    struct KOCOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOCOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOCOI>(arg0, 6, b"KOCOI", b"Kocoi sui", b"Ha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic5krmnfozvpnfdponxm7qn6d6s6outafn46lretvsrz7wclwdgfy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOCOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KOCOI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

