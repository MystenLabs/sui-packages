module 0xf844b86a418e15127fb2568b827d8bb7838dfc549137d5742a400041fb458b7d::misu {
    struct MISU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISU>(arg0, 6, b"MISU", b"MINUNSUI", b"Minun is an Electric-type Pokemon introduced in Generation III, often recognized as the \"Cheering Pokemon\" for its supportive nature.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid2gghzvjvpqneozo3e2eytqbsm7ap2ukut7lywfkgznlit4ker7q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MISU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

