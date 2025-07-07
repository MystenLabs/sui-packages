module 0x71ed1c06898104971580e4d89ae8dd6acb7fd77b311b41ed4c9921948d5e0fd5::blastmon_on_sui {
    struct BLASTMON_ON_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLASTMON_ON_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLASTMON_ON_SUI>(arg0, 6, b"BLASTMON ON SUI", b"BLASTMON", b"BLASTMON ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigapbgzjqp6uso5wdvhlhqtj74i5ej24w5hl2ht6tk3a7w2rpuzgm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLASTMON_ON_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLASTMON_ON_SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

