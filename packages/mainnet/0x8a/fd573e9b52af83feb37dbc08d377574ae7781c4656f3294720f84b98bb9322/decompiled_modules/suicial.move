module 0x8afd573e9b52af83feb37dbc08d377574ae7781c4656f3294720f84b98bb9322::suicial {
    struct SUICIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIAL>(arg0, 6, b"SUICIAL", b"Suicial Network", b"Suicial Network is a social hub for the SUI community  built to connect, share, and grow together in the evolving Web3 space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeia6snxsdt2ykbk5icvun77xxt4vglemz2j2e7kpqag2olwaskb2wq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICIAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

