module 0x58bd9435844c22d2efb2684e342141a7358c3dc929ee5bcd319c7d6c4548ea3f::pokemon {
    struct POKEMON has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEMON>(arg0, 6, b"POKEMON", b"Pokemon On Sui", b"A nostalgic meme token inspired by the world of monster trainers, now listed on Moonbags. Built for fun, powered by community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidy5fp4elqe5syoo4w323tzmz6z3cqmj4zufnxzarcmzstpwdv4c4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEMON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

