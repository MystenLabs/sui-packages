module 0x7a7a784b6cfee449a7e6a45323c91cb1b5c2f0b9f79f4755e5e0b5720a559e72::mkarp {
    struct MKARP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MKARP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MKARP>(arg0, 6, b"MKARP", b"Megikarp", b"Everyones favorite useless fish pokemon,until evolve into dragon on 1M MC! Be ready!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifdhavoqhpwzrv6dpptipofsxpt3stmrnc2z7v7focba6j4lhs5uu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MKARP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MKARP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

