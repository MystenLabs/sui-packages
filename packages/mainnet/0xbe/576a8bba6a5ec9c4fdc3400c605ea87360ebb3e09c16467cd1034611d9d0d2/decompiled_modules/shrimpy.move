module 0xbe576a8bba6a5ec9c4fdc3400c605ea87360ebb3e09c16467cd1034611d9d0d2::shrimpy {
    struct SHRIMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRIMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRIMPY>(arg0, 6, b"SHRIMPY", b"Sui Shrimpy", b"Meet the best genius $SHRIMPY Shrimp on the sui network, Follow his adventure and become a $SHRIMPY squad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib2flkdqetigdfahlcen25qzpi5rzu7ibpdtkfxyylsbkygqccc5e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRIMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHRIMPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

