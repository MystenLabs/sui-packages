module 0x4d2ca1ca7254c2508b56db8908086b1a932fcc89e75338999b34f21ebf8b0161::higm {
    struct HIGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIGM>(arg0, 6, b"HIGM", b"HigherMC", b"HigherMC tools", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibjakzqgf3p53lfgy6bkkc3kuiapahifo3qu6mk4r3nky5zo5utwu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIGM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

