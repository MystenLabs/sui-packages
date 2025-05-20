module 0x1df97346f17705ba53db504244de0e243c4d2c921baed6f5f67d6d7b0c0ea0ed::tdy {
    struct TDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDY>(arg0, 6, b"TDY", b"TEDDY", b"Just fun, teddy ladies babes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie6z7yc2sbenesqga54d4eyzecbswdpeynldevwtb7zr6akdev35a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TDY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

