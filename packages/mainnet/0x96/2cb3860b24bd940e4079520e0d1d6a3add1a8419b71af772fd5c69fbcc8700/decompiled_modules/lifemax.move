module 0x962cb3860b24bd940e4079520e0d1d6a3add1a8419b71af772fd5c69fbcc8700::lifemax {
    struct LIFEMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIFEMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIFEMAX>(arg0, 6, b"LIFEMAX", b"LIFE MAXXING", b"LIFE MAX.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibmrf7vbm7fl7xov7grtnaa7g5rmodyzx73xvmflsbbbr6ig7hdxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIFEMAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIFEMAX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

