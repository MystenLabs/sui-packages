module 0x8f2cb76ab56db048c55c65b4f5d843f065e3ecd2d9a2f21e0695f77df0af2116::puppy {
    struct PUPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPPY>(arg0, 6, b"PUPPY", b"PUPPYSUI", b"The Cutest Mascot of Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifkhjsvl327v4pha4ko2yvhlx5gbxuik2iw5m6ypxfagnleq7al64")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUPPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

