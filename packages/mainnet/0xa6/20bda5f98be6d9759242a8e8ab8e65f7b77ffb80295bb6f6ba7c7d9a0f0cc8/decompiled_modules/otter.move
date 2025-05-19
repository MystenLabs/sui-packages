module 0xa620bda5f98be6d9759242a8e8ab8e65f7b77ffb80295bb6f6ba7c7d9a0f0cc8::otter {
    struct OTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTER>(arg0, 6, b"OTTER", b"Sui Otter", b"Oteter is a sui mascot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigpwze2quohxj3bx3xs6fbd7mdwvzix6q5zl2xoq63675almjnst4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OTTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

