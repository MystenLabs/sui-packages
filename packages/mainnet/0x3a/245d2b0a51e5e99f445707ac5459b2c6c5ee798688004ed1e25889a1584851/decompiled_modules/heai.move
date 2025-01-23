module 0x3a245d2b0a51e5e99f445707ac5459b2c6c5ee798688004ed1e25889a1584851::heai {
    struct HEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEAI>(arg0, 9, b"HEAI", b"Health AI USA", b"MAKE AMERICA HEALTHY AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQmWT9jyAGUcrTHxFhuRn8yAr2NhRJpsHBPioQ7zEv9oz")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HEAI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

