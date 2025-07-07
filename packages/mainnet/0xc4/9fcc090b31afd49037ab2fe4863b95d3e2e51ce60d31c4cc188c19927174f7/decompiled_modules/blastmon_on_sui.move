module 0xc49fcc090b31afd49037ab2fe4863b95d3e2e51ce60d31c4cc188c19927174f7::blastmon_on_sui {
    struct BLASTMON_ON_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTMON_ON_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASTMON_ON_SUI>(arg0, 6, b"BLASTMON_ON_SUI", b"BLASTMON", b"BLASTMON ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigapbgzjqp6uso5wdvhlhqtj74i5ej24w5hl2ht6tk3a7w2rpuzgm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASTMON_ON_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLASTMON_ON_SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

