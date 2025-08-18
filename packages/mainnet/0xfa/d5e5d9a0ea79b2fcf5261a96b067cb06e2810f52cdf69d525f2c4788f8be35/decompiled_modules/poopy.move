module 0xfad5e5d9a0ea79b2fcf5261a96b067cb06e2810f52cdf69d525f2c4788f8be35::poopy {
    struct POOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOPY>(arg0, 6, b"POOPY", b"Poopy Sui", b"From Toilet to The Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifnsmyq4o5s7qzt43gqklrqyb2e5dkxvk7vvwgofihqnzabauwue4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POOPY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

