module 0xb8ec6c76e717ed1445d592505292a7f38c1352aba05e14b9e4386872cee3b986::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT>(arg0, 6, b"TT", b"tutu", b"Let us start a new world. This is for commemoration, for the future and for my children. I hope they can live in a happy and peaceful world where they can enjoy their own growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidp4zzde2sza3enqtibeft3zxjpr6nrmptvpolxz4r2yg5gzhiofu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

