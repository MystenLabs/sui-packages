module 0xccf2bdc9b8a630427a5d91cff8fab55497f7e12bdf2523f54b2385e5de37fb5d::littleman {
    struct LITTLEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITTLEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LITTLEMAN>(arg0, 6, b"LITTLEMAN", b"Sui Little Man", b"Little Man Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigsu7z6pf3xxvzdcvsjupjhrkniawqmz5ozevk2nnsr7fyiiufqty")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LITTLEMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LITTLEMAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

