module 0xb8f0167003a8a04c6a154365f818c85b6ba1e319c80d494b1aeb9f62a781a3b6::wolfe {
    struct WOLFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOLFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOLFE>(arg0, 6, b"WOLFE", b"Wolfe on sui", b"The Greatest wolf dive into Sui as biggest memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaq3rw2qpwwfkdjs5wyp6gaplwnjjiyjugohsaet77k3t2ibl4w6i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOLFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WOLFE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

