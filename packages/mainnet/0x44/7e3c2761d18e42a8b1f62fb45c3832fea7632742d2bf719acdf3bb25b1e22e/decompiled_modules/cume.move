module 0x447e3c2761d18e42a8b1f62fb45c3832fea7632742d2bf719acdf3bb25b1e22e::cume {
    struct CUME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUME>(arg0, 6, b"CUME", b"CUMENDER", b"most retarded (cute) pokemonster on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia7fua5esozas3w5mgg5snvwg3y2tqkhzl2i53n5tgtotht2sqej4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CUME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

